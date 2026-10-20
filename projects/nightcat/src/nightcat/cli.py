"""命令列介面。

    nightcat init         看看這台機器有什麼，產生設定檔
    nightcat check        跑一次所有檢查，印出結果（不記錄、不通知）
    nightcat run          檢查 + 記錄 + 通知（給 cron / systemd timer 用）
    nightcat report       印出日報（--send 送到 Telegram）
    nightcat serve        開本機儀表板
    nightcat test-alert   送一則測試訊息到 Telegram

結束碼：check 沿用 Nagios（0 正常、1 注意、2 嚴重、3 未知）；其他指令 0 成功、1 失敗。
"""

from __future__ import annotations

import argparse
import json
import logging
import sys
import time
import unicodedata
from collections.abc import Sequence
from datetime import datetime
from pathlib import Path

from . import __version__
from .app import run_once
from .checks import Check, Context, build_checks
from .config import (
    Config,
    default_config_path,
    default_host_name,
    load_config,
    parse_config,
    tomllib,
)
from .errors import ConfigError, NightcatError, NotifyError
from .host import Host
from .model import CheckResult, Status, mood, worst
from .notify import ConsoleNotifier, Notifier, TelegramNotifier, deliver
from .probe import generate_config, probe
from .report import build_report, mark_reported
from .runner import run_checks
from .store import Store

log = logging.getLogger("nightcat")


def _width(text: str) -> int:
    return sum(2 if unicodedata.east_asian_width(ch) in "WF" else 1 for ch in text)


def _pad(text: str, width: int) -> str:
    return text + " " * max(0, width - _width(text))


def format_results(host_name: str, results: Sequence[CheckResult], now: float) -> str:
    overall = worst(r.status for r in results)
    lines = [
        f"{mood(overall)} 守夜貓 · {host_name} · {datetime.fromtimestamp(now):%m/%d %H:%M}",
        "",
    ]
    width = min(24, max((_width(r.name) for r in results), default=0))
    for r in results:
        lines.append(f"  {r.status.icon} {_pad(r.name, width)}  {r.summary}")
        if r.hint:
            lines.append(f"     💡 {r.hint}")
    bad = sum(1 for r in results if r.status is not Status.OK)
    lines += ["", "全部正常" if not bad else f"{bad} 項需要注意"]
    return "\n".join(lines)


def _config_path(args: argparse.Namespace) -> Path:
    return Path(args.config).expanduser() if args.config else default_config_path()


def _load(args: argparse.Namespace) -> tuple[Config, list[Check]]:
    cfg = load_config(_config_path(args))
    checks = build_checks(cfg.checks)
    if not checks:
        raise ConfigError(f"設定檔 {cfg.path} 裡沒有啟用任何檢查")
    return cfg, checks


def _auto_config(host: Host) -> Config:
    """沒有設定檔時，用 init 會產生的內容（只取已啟用的檢查）直接跑。"""
    text = generate_config(probe(host), default_host_name())
    return parse_config(tomllib.loads(text))


def _notifier(cfg: Config) -> Notifier:
    if cfg.telegram.enabled:
        return TelegramNotifier(cfg.telegram)
    log.warning("Telegram 還沒設定，通知會印在畫面上")
    return ConsoleNotifier()


# ---------- 子指令 ----------


def cmd_init(args: argparse.Namespace) -> int:
    path = _config_path(args)
    if path.exists() and not args.force:
        raise ConfigError(f"設定檔已經存在：{path}（要覆蓋請加 --force）")
    host = Host()
    found = probe(host)
    text = generate_config(found, args.name or default_host_name())
    parse_config(tomllib.loads(text))  # 產生出來的設定一定要能讀，不然就是 bug
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")
    print(f"✅ 已建立設定檔：{path}")
    print(f"   偵測到：{found.describe()}")
    if not found.batteries:
        print("   💡 沒有可用的電池：停電時會直接關機，電來之後「開機時間」檢查會告訴你停了多久。")
        print(
            "      BIOS 裡如果有「通電自動開機」（ThinkPad 叫 Power On with AC Attach），記得打開。"
        )
    print()
    print("下一步：")
    print("  1. 打開設定檔，填好 [telegram] 的 chat_id，")
    print("     並把 bot token 放進環境變數 NIGHTCAT_TELEGRAM_TOKEN")
    print("  2. 把「你的服務」那一段改成你的備份資料夾、同步伺服器網址")
    print("  3. nightcat check        試跑看看")
    print("  4. nightcat test-alert   確認 Telegram 收得到")
    print("  5. 設定每 5 分鐘自動執行 nightcat run（見 README）")
    return 0


def cmd_check(args: argparse.Namespace) -> int:
    host = Host()
    path = _config_path(args)
    if args.config or path.exists():
        cfg, checks = _load(args)
    else:
        cfg = _auto_config(host)
        checks = build_checks(cfg.checks)
        if not args.json:
            print(f"（還沒有設定檔，先用自動偵測的檢查跑；`nightcat init` 可以產生 {path}）\n")
    if args.only:
        wanted = args.only.lower()
        checks = [c for c in checks if wanted in c.check_id.lower() or wanted in c.name.lower()]
        if not checks:
            raise ConfigError(f"沒有名稱或 id 含「{args.only}」的檢查")
    now = time.time()
    store = Store(cfg.db_path, readonly=True) if cfg.db_path.exists() else None
    ctx = Context(host, now)
    if store:
        ctx.last_seen_before = store.last_run_before
    try:
        results = run_checks(checks, ctx)
    finally:
        if store:
            store.close()
    overall = worst(r.status for r in results)
    if args.json:
        payload = {
            "host": cfg.host_name,
            "ts": now,
            "worst": overall.value,
            "results": [r.to_dict() for r in results],
        }
        print(json.dumps(payload, ensure_ascii=False, indent=2))
    else:
        print(format_results(cfg.host_name, results, now))
    return overall.exit_code


def cmd_run(args: argparse.Namespace) -> int:
    cfg, checks = _load(args)
    notifier: Notifier = ConsoleNotifier() if args.dry_run else _notifier(cfg)
    now = time.time()
    with Store(cfg.db_path) as store:
        try:
            outcome = run_once(cfg, checks, store, Host(), notifier, now)
        except BaseException:
            store.rollback()
            raise
        if args.dry_run:
            store.rollback()
        else:
            store.commit()
    counts = {s: sum(1 for r in outcome.results if r.status is s) for s in Status}
    parts = [f"{counts[s]} {s.label}" for s in Status if counts[s]]
    line = f"檢查了 {len(outcome.results)} 項：{'、'.join(parts)}"
    if outcome.notices:
        sent = "已送出" if outcome.delivered else "沒送出去，稍後補送"
        line += f"；通知 {len(outcome.notices)} 項（{sent}）"
    if outcome.report:
        line += "；送了日報"
    if args.dry_run:
        line += "（試跑，沒有寫入紀錄）"
    if not args.quiet:
        print(line)
    return 0


def cmd_report(args: argparse.Namespace) -> int:
    cfg, checks = _load(args)
    now = time.time()
    host = Host()
    with Store(cfg.db_path) as store:
        results = run_checks(checks, Context(host, now, store.last_run_before))
        text = build_report(cfg.host_name, results, store, now)
        if args.send:
            if not deliver(store, TelegramNotifier(cfg.telegram), text, now):
                store.commit()
                raise NotifyError("日報沒送出去，已排進待送清單，下次 nightcat run 時會補送")
            mark_reported(store, now)
            store.commit()
            print("✅ 日報已送出")
        else:
            print(text)
    return 0


def cmd_serve(args: argparse.Namespace) -> int:
    from .dashboard import make_server

    cfg = load_config(_config_path(args))
    host = args.host or cfg.dashboard_host
    port = args.port or cfg.dashboard_port
    server = make_server(cfg, host, port)
    shown = "127.0.0.1" if host in ("0.0.0.0", "::") else host
    print(f"🐱 儀表板：http://{shown}:{port}  （Ctrl+C 結束）")
    if host in ("0.0.0.0", "::"):
        print("   注意：現在區網裡的其他裝置也看得到這個頁面")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
    return 0


def cmd_test_alert(args: argparse.Namespace) -> int:
    cfg = load_config(_config_path(args))
    notifier = TelegramNotifier(cfg.telegram)
    stamp = datetime.now().strftime("%m/%d %H:%M")
    notifier.send(
        f"😺 {cfg.host_name}：守夜貓通知測試成功！\n之後有狀況會在這裡叫你。\n\n{stamp} · 守夜貓"
    )
    print("✅ 已送出測試訊息，去 Telegram 看看")
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="nightcat",
        description="守夜貓：替家裡的小伺服器守夜，出事就用 Telegram 叫醒你。",
    )
    p.add_argument("--version", action="version", version=f"nightcat {__version__}")
    p.add_argument("-c", "--config", help=f"設定檔路徑（預設 {default_config_path()}）")
    p.add_argument("-v", "--verbose", action="store_true", help="印出更多除錯訊息")
    sub = p.add_subparsers(dest="command", metavar="指令")

    s = sub.add_parser("init", help="偵測這台機器並產生設定檔")
    s.add_argument("--force", action="store_true", help="覆蓋已經存在的設定檔")
    s.add_argument("--name", help="主機顯示名稱（預設用 hostname）")
    s.set_defaults(func=cmd_init)

    s = sub.add_parser("check", help="跑一次檢查並印出結果（不記錄、不通知）")
    s.add_argument(
        "--json", action="store_true", help="輸出 JSON（給其他程式，例如你的 Telegram bot）"
    )
    s.add_argument("--only", help="只跑名稱或 id 含這段文字的檢查")
    s.set_defaults(func=cmd_check)

    s = sub.add_parser("run", help="檢查 + 記錄 + 通知（給 cron / systemd timer 用）")
    s.add_argument("--dry-run", action="store_true", help="通知印在畫面上，不寫入紀錄")
    s.add_argument("-q", "--quiet", action="store_true", help="不印摘要")
    s.set_defaults(func=cmd_run)

    s = sub.add_parser("report", help="印出日報")
    s.add_argument("--send", action="store_true", help="送到 Telegram")
    s.set_defaults(func=cmd_report)

    s = sub.add_parser("serve", help="開本機儀表板")
    s.add_argument("--host", help="聽哪個位址（預設 127.0.0.1）")
    s.add_argument("--port", type=int, help="連接埠（預設 8077）")
    s.set_defaults(func=cmd_serve)

    s = sub.add_parser("test-alert", help="送一則測試訊息到 Telegram")
    s.set_defaults(func=cmd_test_alert)
    return p


def main(argv: Sequence[str] | None = None) -> int:
    for stream in (sys.stdout, sys.stderr):
        # Windows 排程器、重新導向時編碼可能不是 UTF-8，至少不要因為 emoji 當掉
        reconfigure = getattr(stream, "reconfigure", None)
        if reconfigure:
            reconfigure(errors="replace")
    parser = build_parser()
    args = parser.parse_args(argv)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.WARNING,
        format="nightcat: %(message)s",
    )
    if not getattr(args, "func", None):
        parser.print_help()
        return 1
    try:
        return int(args.func(args))
    except NightcatError as e:
        print(f"❌ {e}", file=sys.stderr)
        return 1
    except KeyboardInterrupt:
        return 130
