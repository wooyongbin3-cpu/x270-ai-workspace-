from datetime import datetime

from conftest import NOON
from nightcat.alerts import CheckState, Notice, Policy, evaluate, format_notices, is_quiet
from nightcat.config import parse_config
from nightcat.model import CheckResult, Status

OK, WARN, CRIT, UNKNOWN = Status.OK, Status.WARN, Status.CRIT, Status.UNKNOWN
MIN = 60.0


def res(status: Status, summary: str = "s", event: bool = False) -> CheckResult:
    return CheckResult("disk:/", "磁碟 /", "disk", status, summary, event=event)


class Sim:
    """依序餵狀態進 evaluate，記下每一步有沒有通知。"""

    def __init__(self, confirm: int = 1, remind: float | None = None) -> None:
        self.state: CheckState | None = None
        self.confirm = confirm
        self.remind = remind
        self.t = NOON

    def step(
        self, status: Status, quiet: bool = False, event: bool = False, dt: float = 5 * MIN
    ) -> Notice | None:
        self.t += dt
        self.state, self.transition, notice = evaluate(
            self.state, res(status, event=event), self.confirm, self.t, Policy(quiet, self.remind)
        )
        return notice

    def kinds(self, statuses: list[Status], **kw: bool) -> list[str | None]:
        return [(n.kind if (n := self.step(s, **kw)) else None) for s in statuses]


def test_ok_from_start_is_silent() -> None:
    sim = Sim()
    assert sim.kinds([OK, OK, OK]) == [None, None, None]
    assert sim.state is not None and sim.state.confirmed is OK


def test_problem_then_recovery() -> None:
    sim = Sim()
    assert sim.kinds([OK, CRIT, CRIT, OK, OK]) == [None, "problem", None, "recovery", None]


def test_confirm_needs_consecutive_failures() -> None:
    sim = Sim(confirm=2)
    # 抖一下就好的不通知；連續兩次才算數
    assert sim.kinds([CRIT, OK, CRIT, CRIT, OK]) == [None, None, None, "problem", "recovery"]


def test_confirm_resets_when_failure_kind_changes() -> None:
    sim = Sim(confirm=2)
    assert sim.kinds([WARN, CRIT, CRIT]) == [None, None, "problem"]


def test_getting_better_is_immediate_and_reported_as_change() -> None:
    sim = Sim(confirm=3)
    assert sim.kinds([CRIT, CRIT, CRIT, WARN]) == [None, None, "problem", "change"]


def test_worse_is_a_new_problem() -> None:
    sim = Sim()
    assert sim.kinds([WARN, CRIT]) == ["problem", "problem"]


def test_quiet_hours_defer_warnings_until_morning() -> None:
    sim = Sim()
    assert sim.kinds([WARN, WARN], quiet=True) == [None, None]
    # 早上（安靜時段結束）還沒好：補通知
    notice = sim.step(WARN)
    assert notice is not None and notice.kind == "problem" and notice.new is WARN
    # problem_since 是半夜開始的時間，不是早上通知的時間
    assert notice.problem_since == NOON + 5 * MIN


def test_quiet_hours_problem_that_heals_overnight_is_never_sent() -> None:
    sim = Sim()
    assert sim.kinds([WARN, OK], quiet=True) == [None, None]
    assert sim.step(OK) is None
    assert sim.state is not None and sim.state.problem_since is None


def test_quiet_hours_still_send_critical() -> None:
    sim = Sim()
    assert sim.kinds([CRIT, OK], quiet=True) == ["problem", "recovery"]


def test_event_has_no_recovery_notice() -> None:
    sim = Sim()
    assert sim.kinds([WARN, WARN, OK, OK], event=True) == ["problem", None, None, None]
    assert sim.state is not None and sim.state.notified is OK


def test_reminders_for_lasting_critical() -> None:
    sim = Sim(remind=30 * MIN)
    kinds = sim.kinds([CRIT] * 8)  # 每 5 分鐘一次，共 40 分鐘
    assert kinds[0] == "problem"
    assert kinds.count("reminder") == 1 and kinds.index("reminder") == 6


def test_no_reminders_at_night_or_for_warnings() -> None:
    sim = Sim(remind=10 * MIN)
    assert "reminder" not in sim.kinds([CRIT] * 6, quiet=True)
    sim = Sim(remind=10 * MIN)
    assert "reminder" not in sim.kinds([WARN] * 6)


def test_unknown_counts_as_problem() -> None:
    sim = Sim()
    assert sim.kinds([UNKNOWN, OK]) == ["problem", "recovery"]


def test_transitions_are_recorded_even_when_not_notified() -> None:
    sim = Sim()
    sim.step(WARN, quiet=True)
    assert sim.transition is not None and (sim.transition.old, sim.transition.new) == (OK, WARN)
    sim.step(WARN, quiet=True)
    assert sim.transition is None


def test_format_notices() -> None:
    t = NOON
    problem = Notice(res(CRIT, "已用 96%"), "problem", OK, CRIT, t - 600)
    recovery = Notice(
        CheckResult("http:x", "同步伺服器", "http", OK, "HTTP 200，40 ms"),
        "recovery",
        CRIT,
        OK,
        t - 720,
    )
    text = format_notices("X270", [recovery, problem], t)
    lines = text.splitlines()
    assert lines[0] == "🙀 X270 出狀況了"
    assert lines[2] == "🔴 磁碟 /：已用 96%"
    assert lines[3] == "🟢 同步伺服器：恢復正常，出問題了 12 分鐘（HTTP 200，40 ms）"
    assert lines[-1].endswith("· 守夜貓")

    assert format_notices("X270", [recovery], t).startswith("😺 X270 好起來了")
    warn = Notice(res(WARN, "w"), "problem", OK, WARN, t)
    assert format_notices("X270", [warn], t).startswith("😿 X270 有點不對勁")
    reminder = Notice(res(CRIT, "c"), "reminder", CRIT, CRIT, t - 6 * 3600)
    assert "還沒好，已經 6 小時" in format_notices("X270", [reminder], t)
    change = Notice(res(WARN, "w"), "change", CRIT, WARN, t)
    assert "好一點了（嚴重 → 注意）" in format_notices("X270", [change], t)


def test_is_quiet_uses_local_time() -> None:
    cfg = parse_config({"nightcat": {"quiet_hours": "23:30-07:00"}})
    assert is_quiet(cfg, datetime(2026, 10, 20, 2, 0).timestamp())
    assert not is_quiet(cfg, datetime(2026, 10, 20, 12, 0).timestamp())
    assert not is_quiet(parse_config({}), NOON)


def test_duration_counts_from_first_failure_not_confirmation() -> None:
    sim = Sim(confirm=3)
    sim.step(OK)
    first_failure = sim.t + 5 * MIN
    assert sim.kinds([CRIT, CRIT, CRIT]) == [None, None, "problem"]
    assert sim.transition is not None and sim.transition.ts == first_failure
    assert sim.state is not None and sim.state.problem_since == first_failure
    notice = sim.step(OK)
    assert notice is not None and notice.problem_since == first_failure
    assert "出問題了 15 分鐘" in format_notices("X270", [notice], sim.t)
