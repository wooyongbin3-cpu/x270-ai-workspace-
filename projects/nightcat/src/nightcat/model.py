"""核心資料型別：檢查狀態與檢查結果。"""

from __future__ import annotations

import enum
from collections.abc import Iterable
from dataclasses import dataclass, field
from typing import Any


class Status(enum.Enum):
    OK = "ok"
    WARN = "warn"
    CRIT = "crit"
    UNKNOWN = "unknown"

    @property
    def rank(self) -> int:
        """嚴重程度，用來比較誰比較糟。UNKNOWN 介於 OK 和 WARN 之間。"""
        return _RANK[self]

    @property
    def exit_code(self) -> int:
        """沿用 Nagios 慣例：0 正常、1 注意、2 嚴重、3 未知。"""
        return _EXIT[self]

    @property
    def icon(self) -> str:
        return _ICON[self]

    @property
    def label(self) -> str:
        return _LABEL[self]


_RANK = {Status.OK: 0, Status.UNKNOWN: 1, Status.WARN: 2, Status.CRIT: 3}
_EXIT = {Status.OK: 0, Status.WARN: 1, Status.CRIT: 2, Status.UNKNOWN: 3}
_ICON = {Status.OK: "🟢", Status.WARN: "🟡", Status.CRIT: "🔴", Status.UNKNOWN: "⚪"}
_LABEL = {Status.OK: "正常", Status.WARN: "注意", Status.CRIT: "嚴重", Status.UNKNOWN: "未知"}


def worst(statuses: Iterable[Status]) -> Status:
    """回傳最嚴重的狀態；沒有任何狀態時算正常。"""
    return max(statuses, key=lambda s: s.rank, default=Status.OK)


def mood(status: Status) -> str:
    """貓咪表情，跟著整體狀態變。"""
    return {Status.OK: "😺", Status.UNKNOWN: "😼", Status.WARN: "😿", Status.CRIT: "🙀"}[status]


@dataclass
class CheckResult:
    check_id: str
    name: str
    kind: str
    status: Status
    summary: str
    metrics: dict[str, float] = field(default_factory=dict)
    hint: str | None = None
    # 一次性事件（例如重新開機）：出現時通知，回到正常時不另外發「已恢復」
    event: bool = False
    # 儀表板畫趨勢線用的主要數值（metrics 裡的 key）
    primary: str | None = None
    duration_ms: float = 0.0

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.check_id,
            "name": self.name,
            "kind": self.kind,
            "status": self.status.value,
            "summary": self.summary,
            "metrics": self.metrics,
            "hint": self.hint,
            "primary": self.primary,
            "duration_ms": round(self.duration_ms, 1),
        }
