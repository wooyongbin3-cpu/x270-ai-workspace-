"""每日報告：現在的狀態、過去 24 小時發生的事、磁碟還能撐幾天、給你的建議。"""

from __future__ import annotations

from collections.abc import Sequence
from datetime import datetime, time

from . import __version__
from .model import CheckResult, Status, mood, worst
from .store import Store

_WEEKDAYS = "一二三四五六日"
DAY = 86400.0


def disk_forecast(series: Sequence[Sequence[float]], min_span: float = 6 * 3600) -> float | None:
    """series 是 [[ts, used_bytes, free_bytes], ...]。用最小平方法估計每秒增加多少，回傳還剩幾天會滿。"""
    if len(series) < 3:
        return None
    span = series[-1][0] - series[0][0]
    if span < min_span:
        return None
    n = len(series)
    mean_t = sum(p[0] for p in series) / n
    mean_u = sum(p[1] for p in series) / n
    var = sum((p[0] - mean_t) ** 2 for p in series)
    if var == 0:
        return None
    slope = sum((p[0] - mean_t) * (p[1] - mean_u) for p in series) / var
    if slope <= 0:
        return None
    return series[-1][2] / slope / DAY


def report_due(daily_time: time | None, store: Store, now: float) -> bool:
    if daily_time is None:
        return False
    local = datetime.fromtimestamp(now)
    if local.time() < daily_time:
        return False
    return store.meta_get("last_report") != local.date().isoformat()


def start_schedule(daily_time: time | None, store: Store, now: float) -> None:
    """第一次執行時呼叫：如果今天日報的時間已經過了，從明天早上開始，不要一裝好就送日報。"""
    if daily_time is None or store.last_run_ts() is not None:
        return
    if store.meta_get("last_report") is None and datetime.fromtimestamp(now).time() >= daily_time:
        mark_reported(store, now)


def mark_reported(store: Store, now: float) -> None:
    store.meta_set("last_report", datetime.fromtimestamp(now).date().isoformat())


def build_report(host_name: str, results: Sequence[CheckResult], store: Store, now: float) -> str:
    local = datetime.fromtimestamp(now)
    overall = worst(r.status for r in results)
    bad = [r for r in results if r.status is not Status.OK]
    lines = [f"☀️ {host_name} 日報 · {local:%m/%d}（{_WEEKDAYS[local.weekday()]}）"]
    if bad:
        lines.append(f"{mood(overall)} 有 {len(bad)} 項需要注意")
    else:
        lines.append(f"{mood(Status.OK)} 全部正常")

    lines += ["", "【現在】"]
    warnings: list[str] = []
    for r in sorted(results, key=lambda r: -r.status.rank):
        line = f"{r.status.icon} {r.name}：{r.summary}"
        if r.kind == "disk":
            days = disk_forecast(
                store.metric_series(r.check_id, ("used_bytes", "free_bytes"), now - 7 * DAY)
            )
            if days is not None and days < 365:
                line += f"，照目前速度約 {days:.0f} 天後會滿"
                if days < 14:
                    warnings.append(f"⚠️ {r.name} 大約 {days:.0f} 天後會滿，該清一清了")
        lines.append(line)

    lines += ["", "【過去 24 小時】"]
    events = store.events_since(now - DAY)
    if events:
        for e in events:
            when = datetime.fromtimestamp(e.ts)
            if e.new is Status.OK:
                lines.append(f"{when:%H:%M} {Status.OK.icon} {e.name} 恢復正常")
            else:
                lines.append(f"{when:%H:%M} {e.new.icon} {e.name}：{e.summary}")
    else:
        lines.append("一切平靜 ✨")

    hints = list(dict.fromkeys(r.hint for r in results if r.hint))
    if warnings or hints:
        lines += ["", "【建議】"]
        lines += warnings
        lines += [f"💡 {h}" for h in hints]

    runs = store.run_count_since(now - DAY)
    lines += ["", f"過去 24 小時檢查了 {runs} 次 · 守夜貓 v{__version__}"]
    return "\n".join(lines)
