"""讀取與驗證 TOML 設定檔。

設定檔分三塊：
    [nightcat]   全域設定（主機名稱、安靜時段、日報時間…）
    [telegram]   通知用的 bot token 與 chat id
    [[check]]    一個區塊一項檢查，type 決定檢查種類

打錯字的選項會直接報錯，而不是默默被忽略：監控設定錯了卻沒發現，比沒有監控更糟。
"""

from __future__ import annotations

import os
import sys
from dataclasses import dataclass, field
from datetime import time
from pathlib import Path
from typing import Any

from .errors import ConfigError
from .units import parse_clock, parse_duration, parse_time_range

if sys.version_info >= (3, 11):
    import tomllib
else:  # pragma: no cover - 只在 3.10 走這條
    import tomli as tomllib

TOKEN_ENV = "NIGHTCAT_TELEGRAM_TOKEN"
CHAT_ID_ENV = "NIGHTCAT_TELEGRAM_CHAT_ID"
CONFIG_ENV = "NIGHTCAT_CONFIG"


@dataclass
class TelegramConfig:
    token: str | None = None
    chat_id: str | None = None
    api_base: str = "https://api.telegram.org"

    @property
    def enabled(self) -> bool:
        return bool(self.token and self.chat_id)


@dataclass
class CheckSpec:
    """設定檔裡的一個 [[check]] 區塊，選項留給各檢查自己驗證。"""

    type: str
    index: int
    name: str | None = None
    confirm: int | None = None
    options: dict[str, Any] = field(default_factory=dict)


@dataclass
class Config:
    host_name: str
    data_dir: Path
    quiet_hours: tuple[time, time] | None = None
    daily_report: time | None = None
    remind_every: float | None = 6 * 3600
    keep_days: int = 30
    telegram: TelegramConfig = field(default_factory=TelegramConfig)
    dashboard_host: str = "127.0.0.1"
    dashboard_port: int = 8077
    stale_after: float = 20 * 60
    checks: list[CheckSpec] = field(default_factory=list)
    path: Path | None = None

    @property
    def db_path(self) -> Path:
        return self.data_dir / "nightcat.db"


def default_config_path() -> Path:
    env = os.environ.get(CONFIG_ENV)
    if env:
        return Path(env).expanduser()
    if os.name == "nt":
        base = Path(os.environ.get("APPDATA") or Path.home() / "AppData" / "Roaming")
    else:
        base = Path(os.environ.get("XDG_CONFIG_HOME") or Path.home() / ".config")
    return base / "nightcat" / "config.toml"


def default_data_dir() -> Path:
    if os.name == "nt":
        base = Path(os.environ.get("LOCALAPPDATA") or Path.home() / "AppData" / "Local")
    else:
        base = Path(os.environ.get("XDG_DATA_HOME") or Path.home() / ".local" / "share")
    return base / "nightcat"


def default_host_name() -> str:
    import socket

    return socket.gethostname() or "server"


_GLOBAL_KEYS = {
    "host_name",
    "data_dir",
    "quiet_hours",
    "daily_report",
    "remind_every",
    "keep_days",
}
_TELEGRAM_KEYS = {"token", "token_env", "chat_id", "api_base"}
_DASHBOARD_KEYS = {"host", "port", "stale_after"}
_TOP_KEYS = {"nightcat", "telegram", "dashboard", "check"}
_CHECK_COMMON = {"type", "name", "confirm", "enabled"}


def load_config(path: Path) -> Config:
    try:
        raw = path.read_bytes()
    except FileNotFoundError:
        raise ConfigError(
            f"找不到設定檔：{path}\n先執行 `nightcat init` 產生一份，或用 --config 指定路徑。"
        ) from None
    except OSError as e:
        raise ConfigError(f"讀不了設定檔 {path}：{e}") from None
    try:
        data = tomllib.loads(raw.decode("utf-8-sig"))
    except (tomllib.TOMLDecodeError, UnicodeDecodeError) as e:
        raise ConfigError(f"設定檔 {path} 格式錯誤：{e}") from None
    cfg = parse_config(data)
    cfg.path = path
    return cfg


def parse_config(data: dict[str, Any]) -> Config:
    _reject_unknown(data, _TOP_KEYS, "設定檔最外層")
    g = _table(data, "nightcat")
    _reject_unknown(g, _GLOBAL_KEYS, "[nightcat]")

    cfg = Config(
        host_name=_str(g, "host_name", "[nightcat]") or default_host_name(),
        data_dir=Path(_str(g, "data_dir", "[nightcat]") or default_data_dir()).expanduser(),
    )
    if "quiet_hours" in g:
        cfg.quiet_hours = parse_time_range(g["quiet_hours"]) if g["quiet_hours"] else None
    if "daily_report" in g:
        cfg.daily_report = parse_clock(g["daily_report"]) if g["daily_report"] else None
    if "remind_every" in g:
        value = g["remind_every"]
        cfg.remind_every = parse_duration(value) if value not in (0, "", "0", False) else None
    if "keep_days" in g:
        cfg.keep_days = _positive_int(g["keep_days"], "[nightcat] keep_days")

    t = _table(data, "telegram")
    _reject_unknown(t, _TELEGRAM_KEYS, "[telegram]")
    token_env = _str(t, "token_env", "[telegram]") or TOKEN_ENV
    chat_id = t.get("chat_id")
    if chat_id is not None and not isinstance(chat_id, (str, int)):
        raise ConfigError("[telegram] chat_id 要是數字或字串")
    cfg.telegram = TelegramConfig(
        token=_str(t, "token", "[telegram]") or os.environ.get(token_env) or None,
        chat_id=str(chat_id) if chat_id not in (None, "") else os.environ.get(CHAT_ID_ENV),
        api_base=(_str(t, "api_base", "[telegram]") or "https://api.telegram.org").rstrip("/"),
    )

    d = _table(data, "dashboard")
    _reject_unknown(d, _DASHBOARD_KEYS, "[dashboard]")
    cfg.dashboard_host = _str(d, "host", "[dashboard]") or cfg.dashboard_host
    if "port" in d:
        cfg.dashboard_port = _positive_int(d["port"], "[dashboard] port")
    if "stale_after" in d:
        cfg.stale_after = parse_duration(d["stale_after"])

    checks = data.get("check", [])
    if not isinstance(checks, list):
        raise ConfigError("檢查項目要寫成 [[check]]（兩層中括號）")
    for i, block in enumerate(checks, start=1):
        if not isinstance(block, dict):
            raise ConfigError(f"第 {i} 個 [[check]] 格式不對")
        spec = _parse_check(block, i)
        if spec is not None:
            cfg.checks.append(spec)
    return cfg


def _parse_check(block: dict[str, Any], index: int) -> CheckSpec | None:
    where = f"第 {index} 個 [[check]]"
    kind = block.get("type")
    if not isinstance(kind, str) or not kind:
        raise ConfigError(f'{where} 少了 type（例如 type = "disk"）')
    enabled = block.get("enabled", True)
    if not isinstance(enabled, bool):
        raise ConfigError(f"{where} 的 enabled 要是 true 或 false")
    if not enabled:
        return None
    name = block.get("name")
    if name is not None and not isinstance(name, str):
        raise ConfigError(f"{where} 的 name 要是字串")
    confirm = None
    if "confirm" in block:
        confirm = _positive_int(block["confirm"], f"{where} 的 confirm")
    options = {k: v for k, v in block.items() if k not in _CHECK_COMMON}
    return CheckSpec(type=kind, index=index, name=name or None, confirm=confirm, options=options)


def _table(data: dict[str, Any], key: str) -> dict[str, Any]:
    value = data.get(key, {})
    if not isinstance(value, dict):
        raise ConfigError(f"[{key}] 要是一個表格區塊")
    return value


def _str(table: dict[str, Any], key: str, where: str) -> str | None:
    value = table.get(key)
    if value is None:
        return None
    if not isinstance(value, str):
        raise ConfigError(f"{where} {key} 要是字串")
    return value


def _positive_int(value: object, where: str) -> int:
    if isinstance(value, bool) or not isinstance(value, int) or value < 1:
        raise ConfigError(f"{where} 要是正整數，現在是 {value!r}")
    return value


def _reject_unknown(table: dict[str, Any], allowed: set[str], where: str) -> None:
    unknown = sorted(set(table) - allowed)
    if unknown:
        raise ConfigError(
            f"{where} 有不認得的選項：{', '.join(unknown)}（可用：{', '.join(sorted(allowed))}）"
        )
