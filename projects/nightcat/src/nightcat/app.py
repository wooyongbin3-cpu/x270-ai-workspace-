"""一次完整的執行：檢查 → 記錄 → 判斷要不要通知 → 送出 → 日報 → 清理舊資料。

給 cron / systemd timer 每幾分鐘呼叫一次（`nightcat run`）。
"""

from __future__ import annotations

from dataclasses import dataclass, field

from .alerts import Notice, Policy, Transition, evaluate, format_notices, is_quiet
from .checks import Check, Context
from .config import Config
from .host import Host
from .model import CheckResult
from .notify import Notifier, deliver, flush_outbox
from .report import build_report, mark_reported, report_due, start_schedule
from .runner import run_checks
from .store import Store


@dataclass
class RunOutcome:
    results: list[CheckResult]
    notices: list[Notice] = field(default_factory=list)
    transitions: list[Transition] = field(default_factory=list)
    message: str | None = None
    delivered: bool | None = None
    report: str | None = None


def run_once(
    cfg: Config,
    checks: list[Check],
    store: Store,
    host: Host,
    notifier: Notifier,
    now: float,
    deadline: float = 60.0,
) -> RunOutcome:
    start_schedule(cfg.daily_report, store, now)
    ctx = Context(host=host, now=now, last_seen_before=store.last_run_before)
    results = run_checks(checks, ctx, deadline=deadline)
    outcome = RunOutcome(results)

    confirm = {c.check_id: c.confirm for c in checks}
    states = store.get_states()
    policy = Policy(quiet=is_quiet(cfg, now), remind_every=cfg.remind_every)
    for r in results:
        state, transition, notice = evaluate(
            states.get(r.check_id), r, confirm.get(r.check_id, 1), now, policy
        )
        store.put_state(state)
        if transition:
            store.add_event(transition)
            outcome.transitions.append(transition)
        if notice:
            outcome.notices.append(notice)
    store.record_run(now, results)

    if outcome.notices:
        outcome.message = format_notices(cfg.host_name, outcome.notices, now)
        outcome.delivered = deliver(store, notifier, outcome.message, now)
    else:
        flush_outbox(store, notifier)

    if report_due(cfg.daily_report, store, now):
        outcome.report = build_report(cfg.host_name, results, store, now)
        deliver(store, notifier, outcome.report, now)
        mark_reported(store, now)

    store.prune(now - cfg.keep_days * 86400)
    return outcome
