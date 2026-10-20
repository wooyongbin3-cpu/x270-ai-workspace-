"""所有檢查種類的註冊表。"""

from __future__ import annotations

from collections.abc import Iterable

from ..config import CheckSpec
from ..errors import ConfigError
from .backup import BackupCheck
from .base import Check, Context
from .battery import BatteryCheck
from .network import HttpCheck, TcpCheck
from .services import CommandCheck, SystemdCheck
from .system import DiskCheck, LoadCheck, MemoryCheck, ProcessCheck, TemperatureCheck, UptimeCheck

REGISTRY: dict[str, type[Check]] = {
    cls.kind: cls
    for cls in (
        DiskCheck,
        MemoryCheck,
        LoadCheck,
        TemperatureCheck,
        BatteryCheck,
        UptimeCheck,
        BackupCheck,
        HttpCheck,
        TcpCheck,
        SystemdCheck,
        ProcessCheck,
        CommandCheck,
    )
}


def build_check(spec: CheckSpec) -> Check:
    where = f"第 {spec.index} 個 [[check]]"
    cls = REGISTRY.get(spec.type)
    if cls is None:
        raise ConfigError(f'{where}：不認得的 type "{spec.type}"（可用：{", ".join(REGISTRY)}）')
    try:
        return cls(spec.name, spec.confirm, **spec.options)
    except ConfigError as e:
        raise ConfigError(f"{where}（{spec.type}）：{e}") from None


def build_checks(specs: Iterable[CheckSpec]) -> list[Check]:
    checks: list[Check] = []
    seen: dict[str, int] = {}
    for spec in specs:
        check = build_check(spec)
        # 同一個 id 出現兩次（例如兩個 disk 都沒寫 path）時加上編號，避免歷史紀錄混在一起
        n = seen.get(check.check_id, 0) + 1
        seen[check.check_id] = n
        if n > 1:
            check.check_id = f"{check.check_id}#{n}"
        checks.append(check)
    return checks


__all__ = ["REGISTRY", "Check", "Context", "build_check", "build_checks"]
