"""同時執行所有檢查。

每項檢查跑在自己的 daemon thread：卡死的網路掛載點（statvfs 永遠不回來）之類的情況，
只會讓那一項變成「未知」，不會把整個 nightcat 拖住；程式結束時也不必等它。
"""

from __future__ import annotations

import threading
import time
from collections.abc import Sequence

from .checks import Check, Context
from .model import CheckResult, Status


def _crashed(check: Check, summary: str) -> CheckResult:
    return CheckResult(
        check_id=check.check_id,
        name=check.name,
        kind=check.kind,
        status=Status.UNKNOWN,
        summary=summary,
        event=check.event,
        primary=check.primary,
    )


def run_one(check: Check, ctx: Context) -> CheckResult:
    start = time.perf_counter()
    try:
        result = check.run(ctx)
    except Exception as e:  # 檢查本身的 bug 不應該讓其他檢查跟著停
        result = _crashed(check, f"檢查本身出錯：{type(e).__name__}: {e}")
    result.duration_ms = (time.perf_counter() - start) * 1000
    return result


def run_checks(checks: Sequence[Check], ctx: Context, deadline: float = 60.0) -> list[CheckResult]:
    results: list[CheckResult | None] = [None] * len(checks)

    def work(i: int, check: Check) -> None:
        results[i] = run_one(check, ctx)

    threads = [
        threading.Thread(target=work, args=(i, c), name=f"nightcat-{c.kind}", daemon=True)
        for i, c in enumerate(checks)
    ]
    for t in threads:
        t.start()
    end = time.monotonic() + deadline
    for t in threads:
        t.join(max(0.0, end - time.monotonic()))

    final: list[CheckResult] = []
    for check, result in zip(checks, results, strict=True):
        if result is None:
            result = _crashed(check, f"超過 {deadline:g} 秒沒有完成（卡住了？）")
            result.duration_ms = deadline * 1000
        final.append(result)
    return final
