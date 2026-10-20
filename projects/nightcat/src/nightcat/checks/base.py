"""檢查項目的共用基底：選項宣告、驗證，以及結果的建構。"""

from __future__ import annotations

import shlex
from abc import ABC, abstractmethod
from collections.abc import Callable
from dataclasses import dataclass, field
from typing import Any, ClassVar

from ..errors import ConfigError
from ..host import Host
from ..model import CheckResult, Status
from ..units import parse_duration, parse_size

REQUIRED: Any = object()


@dataclass(frozen=True)
class Opt:
    """一個選項的型別與預設值。kind 決定怎麼解析設定檔裡的值。"""

    kind: str
    default: Any = REQUIRED


def _no_history(_ts: float) -> float | None:
    return None


@dataclass
class Context:
    host: Host
    now: float
    # 查「某個時間點之前最後一次執行」的時間，用來推算停機多久
    last_seen_before: Callable[[float], float | None] = field(default=_no_history)


_STATUS_NAMES = {"ok": Status.OK, "warn": Status.WARN, "crit": Status.CRIT}


def _coerce(key: str, opt: Opt, value: Any) -> Any:
    if value is None:
        return None
    kind = opt.kind
    if kind == "str":
        if not isinstance(value, str):
            raise ConfigError(f"{key} 要是字串")
        return value
    if kind == "num":
        if isinstance(value, bool) or not isinstance(value, (int, float)):
            raise ConfigError(f"{key} 要是數字")
        return float(value)
    if kind == "int":
        if isinstance(value, bool) or not isinstance(value, int):
            raise ConfigError(f"{key} 要是整數")
        return value
    if kind == "bool":
        if not isinstance(value, bool):
            raise ConfigError(f"{key} 要是 true 或 false")
        return value
    if kind == "duration":
        return parse_duration(value)
    if kind == "size":
        return parse_size(value)
    if kind == "status":
        if not isinstance(value, str) or value.lower() not in _STATUS_NAMES:
            raise ConfigError(f'{key} 要是 "ok"、"warn" 或 "crit"')
        return _STATUS_NAMES[value.lower()]
    if kind == "cmd":
        if isinstance(value, str):
            argv = shlex.split(value)
        elif isinstance(value, list) and all(isinstance(x, str) for x in value):
            argv = list(value)
        else:
            raise ConfigError(f"{key} 要是字串或字串陣列")
        if not argv:
            raise ConfigError(f"{key} 不能是空的")
        return argv
    if kind == "ints":
        items = value if isinstance(value, list) else [value]
        if not items or any(isinstance(x, bool) or not isinstance(x, int) for x in items):
            raise ConfigError(f"{key} 要是整數或整數陣列")
        return list(items)
    raise AssertionError(f"unknown option kind {kind}")


class Check(ABC):
    kind: ClassVar[str]
    label: ClassVar[str]
    options: ClassVar[dict[str, Opt]] = {}
    default_confirm: ClassVar[int] = 1
    primary: ClassVar[str | None] = None
    event: ClassVar[bool] = False

    def __init__(self, name: str | None = None, confirm: int | None = None, **options: Any):
        self.opts = self._validate(options)
        self.name = name or self.default_name()
        self.confirm = confirm or self.default_confirm
        ident = self.ident()
        self.check_id = f"{self.kind}:{ident}" if ident else self.kind

    @classmethod
    def _validate(cls, given: dict[str, Any]) -> dict[str, Any]:
        unknown = sorted(set(given) - set(cls.options))
        if unknown:
            allowed = ", ".join(sorted(cls.options)) or "（沒有）"
            raise ConfigError(f"不認得的選項 {', '.join(unknown)}（可用：{allowed}）")
        opts: dict[str, Any] = {}
        for key, opt in cls.options.items():
            if key in given:
                opts[key] = _coerce(key, opt, given[key])
            elif opt.default is REQUIRED:
                raise ConfigError(f"少了必填選項 {key}")
            else:
                opts[key] = _coerce(key, opt, opt.default)
        return opts

    def default_name(self) -> str:
        return self.label

    def ident(self) -> str:
        """區分同種檢查的識別字，設定沒變時要保持穩定，歷史紀錄靠它對應。
        記憶體、電池這類一台機器只有一個的檢查回傳空字串，id 就是 kind 本身。"""
        return ""

    @abstractmethod
    def run(self, ctx: Context) -> CheckResult: ...

    def result(
        self,
        status: Status,
        summary: str,
        metrics: dict[str, float] | None = None,
        hint: str | None = None,
    ) -> CheckResult:
        return CheckResult(
            check_id=self.check_id,
            name=self.name,
            kind=self.kind,
            status=status,
            summary=summary,
            metrics=metrics or {},
            hint=hint,
            event=self.event,
            primary=self.primary,
        )


def threshold_status(value: float, warn: float | None, crit: float | None) -> Status:
    """數值越大越糟的情況（使用率、溫度…）。"""
    if crit is not None and value >= crit:
        return Status.CRIT
    if warn is not None and value >= warn:
        return Status.WARN
    return Status.OK
