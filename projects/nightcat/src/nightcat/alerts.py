"""決定什麼時候該通知。

每項檢查記住三件事：
    confirmed  目前「確認」的狀態（變糟要連續 confirm 次才算數，避免網路抖一下就吵你）
    notified   你最後一次被告知的狀態
    pending    還在等待確認的新狀態

只要 confirmed 和 notified 不一樣，就代表有事情你還不知道，該發通知了。
安靜時段只是「先不講」：早上醒來如果問題還在，照樣會通知；半夜已經自己好了的，
就只出現在日報裡，不會吵你。
"""

from __future__ import annotations

import dataclasses
from dataclasses import dataclass
from datetime import datetime

from .config import Config
from .model import CheckResult, Status, mood
from .units import fmt_duration, in_time_range


@dataclass
class CheckState:
    check_id: str
    confirmed: Status = Status.OK
    since: float = 0.0
    pending: Status | None = None
    streak: int = 0
    notified: Status = Status.OK
    notified_at: float | None = None
    # 最近一次離開「正常」的時間，用來算「出問題多久」
    problem_since: float | None = None
    # pending 第一次出現的時間：確認之後，事件和「出問題多久」從這裡起算，而不是確認的那一刻
    pending_since: float | None = None


@dataclass
class Transition:
    """確認後的狀態改變，會寫進事件紀錄（日報用），跟有沒有通知無關。"""

    check_id: str
    name: str
    old: Status
    new: Status
    ts: float
    summary: str


@dataclass
class Notice:
    result: CheckResult
    kind: str  # problem / recovery / change / reminder
    old: Status
    new: Status
    problem_since: float | None


@dataclass
class Policy:
    quiet: bool = False
    remind_every: float | None = None


def is_quiet(cfg: Config, now: float) -> bool:
    if cfg.quiet_hours is None:
        return False
    return in_time_range(datetime.fromtimestamp(now).time(), *cfg.quiet_hours)


def _involves_crit(old: Status, new: Status) -> bool:
    return new is Status.CRIT or old is Status.CRIT


def evaluate(
    prev: CheckState | None,
    result: CheckResult,
    confirm: int,
    now: float,
    policy: Policy,
) -> tuple[CheckState, Transition | None, Notice | None]:
    state = dataclasses.replace(prev) if prev else CheckState(check_id=result.check_id, since=now)
    observed = result.status
    transition = None

    # 1) 確認狀態
    if observed == state.confirmed:
        state.pending, state.streak, state.pending_since = None, 0, None
    else:
        if observed == state.pending:
            state.streak += 1
        else:
            state.pending, state.streak, state.pending_since = observed, 1, now
        # 變糟要連續確認；變好立刻算數
        needed = confirm if observed.rank > state.confirmed.rank else 1
        if state.streak >= needed:
            began = state.pending_since if state.pending_since is not None else now
            transition = Transition(
                result.check_id, result.name, state.confirmed, observed, began, result.summary
            )
            if state.confirmed is Status.OK:
                state.problem_since = began
            state.confirmed, state.since = observed, began
            state.pending, state.streak, state.pending_since = None, 0, None

    # 2) 要不要通知
    notice = None
    if state.confirmed != state.notified:
        old, new = state.notified, state.confirmed
        if result.event and new is Status.OK:
            state.notified = new  # 一次性事件回到正常，不另外通知
        elif policy.quiet and not _involves_crit(old, new):
            pass  # 安靜時段：先記著，等時段結束還沒好再說
        else:
            if new is Status.OK:
                kind = "recovery"
            elif new.rank > old.rank:
                kind = "problem"
            else:
                kind = "change"
            notice = Notice(result, kind, old, new, state.problem_since)
            state.notified, state.notified_at = new, now
    elif (
        state.confirmed is Status.CRIT
        and policy.remind_every
        and not policy.quiet
        and state.notified_at is not None
        and now - state.notified_at >= policy.remind_every
    ):
        notice = Notice(result, "reminder", Status.CRIT, Status.CRIT, state.problem_since)
        state.notified_at = now

    if state.confirmed is Status.OK and state.notified is Status.OK:
        state.problem_since = None
    return state, transition, notice


def format_notices(host_name: str, notices: list[Notice], now: float) -> str:
    bad = [n for n in notices if n.kind in ("problem", "reminder")]
    if any(n.new is Status.CRIT for n in bad):
        header = f"{mood(Status.CRIT)} {host_name} 出狀況了"
    elif bad:
        header = f"{mood(Status.WARN)} {host_name} 有點不對勁"
    else:
        header = f"{mood(Status.OK)} {host_name} 好起來了"

    order = {"problem": 0, "reminder": 1, "change": 2, "recovery": 3}
    lines = [header, ""]
    for n in sorted(notices, key=lambda n: (order[n.kind], -n.new.rank)):
        r = n.result
        lasted = fmt_duration(now - n.problem_since) if n.problem_since is not None else None
        if n.kind == "recovery":
            extra = f"，出問題了 {lasted}" if lasted else ""
            lines.append(f"{Status.OK.icon} {r.name}：恢復正常{extra}（{r.summary}）")
        elif n.kind == "reminder":
            extra = f"，已經 {lasted}" if lasted else ""
            lines.append(f"{n.new.icon} {r.name}：還沒好{extra}。{r.summary}")
        elif n.kind == "change":
            lines.append(
                f"{n.new.icon} {r.name}：好一點了（{n.old.label} → {n.new.label}）。{r.summary}"
            )
        else:
            lines.append(f"{n.new.icon} {r.name}：{r.summary}")
    lines += ["", f"{datetime.fromtimestamp(now):%m/%d %H:%M} · 守夜貓"]
    return "\n".join(lines)
