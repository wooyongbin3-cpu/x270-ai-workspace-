"""系統資源：磁碟、記憶體、負載、溫度、開機時間、行程。"""

from __future__ import annotations

import os
import re
from typing import Any

from ..errors import ConfigError
from ..model import CheckResult, Status
from ..units import fmt_bytes, fmt_duration
from .base import Check, Context, Opt, threshold_status


class DiskCheck(Check):
    kind = "disk"
    label = "磁碟"
    primary = "used_pct"
    options = {
        "path": Opt("str", "/"),
        "warn": Opt("num", 85),
        "crit": Opt("num", 95),
        "min_free": Opt("size", None),
        # 外接備份硬碟：沒掛載時 disk_usage 會默默量到根目錄，所以要另外確認
        "must_be_mount": Opt("bool", False),
    }

    def default_name(self) -> str:
        return f"磁碟 {self.opts['path']}"

    def ident(self) -> str:
        return str(self.opts["path"])

    def run(self, ctx: Context) -> CheckResult:
        path: str = self.opts["path"]
        if not os.path.exists(path):
            return self.result(Status.CRIT, f"路徑不存在：{path}")
        if self.opts["must_be_mount"] and not ctx.host.is_mount(path):
            return self.result(Status.CRIT, f"{path} 沒有掛載（外接硬碟掉了？）")
        u = ctx.host.disk_usage(path)
        size = u.used + u.free  # 跟 df 一樣，不算 root 保留區
        pct = u.used / size * 100 if size else 0.0
        status = threshold_status(pct, self.opts["warn"], self.opts["crit"])
        min_free = self.opts["min_free"]
        if min_free is not None and u.free < min_free:
            status = Status.CRIT
        summary = f"已用 {pct:.0f}%（剩 {fmt_bytes(u.free)} / 共 {fmt_bytes(u.total)}）"
        metrics = {
            "used_pct": round(pct, 2),
            "used_bytes": u.used,
            "free_bytes": u.free,
            "total_bytes": u.total,
        }
        return self.result(status, summary, metrics)


class MemoryCheck(Check):
    kind = "memory"
    label = "記憶體"
    primary = "used_pct"
    options = {
        "warn": Opt("num", 90),
        "crit": Opt("num", 97),
        "swap_warn": Opt("num", None),
    }

    def run(self, ctx: Context) -> CheckResult:
        mem = ctx.host.memory()
        if mem is None:
            return self.result(
                Status.UNKNOWN, "讀不到記憶體資訊（Windows/macOS 需要 pip install psutil）"
            )
        pct = (1 - mem.available / mem.total) * 100
        status = threshold_status(pct, self.opts["warn"], self.opts["crit"])
        summary = f"已用 {pct:.0f}%（可用 {fmt_bytes(mem.available)} / 共 {fmt_bytes(mem.total)}）"
        metrics = {"used_pct": round(pct, 2), "available_bytes": mem.available}
        if mem.swap_total:
            swap_pct = (1 - mem.swap_free / mem.swap_total) * 100
            metrics["swap_pct"] = round(swap_pct, 2)
            swap_warn = self.opts["swap_warn"]
            if swap_warn is not None and swap_pct >= swap_warn:
                status = max(status, Status.WARN, key=lambda s: s.rank)
                summary += f"，swap 用了 {swap_pct:.0f}%"
        return self.result(status, summary, metrics)


class LoadCheck(Check):
    kind = "load"
    label = "CPU 負載"
    primary = "per_cpu"
    # 用 5 分鐘平均、除以核心數；短暫的尖峰不會吵你
    options = {
        "warn": Opt("num", 1.5),
        "crit": Opt("num", 3.0),
    }

    def run(self, ctx: Context) -> CheckResult:
        load = ctx.host.load()
        if load is None:
            return self.result(
                Status.UNKNOWN, "讀不到 CPU 負載（Windows/macOS 需要 pip install psutil）"
            )
        per_cpu = load.five / max(1, load.cpus)
        status = threshold_status(per_cpu, self.opts["warn"], self.opts["crit"])
        if load.source == "cpu_percent":
            summary = f"CPU 使用率 {per_cpu * 100:.0f}%（{load.cpus} 執行緒）"
        else:
            summary = f"5 分鐘平均負載 {load.five:.2f}（{load.cpus} 執行緒，每個 {per_cpu:.2f}）"
        metrics = {"load1": load.one, "load5": load.five, "per_cpu": round(per_cpu, 3)}
        return self.result(status, summary, metrics)


class TemperatureCheck(Check):
    kind = "temperature"
    label = "溫度"
    primary = "max_c"
    options = {
        "warn": Opt("num", 80),
        "crit": Opt("num", 92),
        # 只看名稱含這段文字的感測器，例如 "x86_pkg_temp" 或 "coretemp"
        "sensor": Opt("str", None),
    }

    def ident(self) -> str:
        return str(self.opts["sensor"] or "")

    def run(self, ctx: Context) -> CheckResult:
        sensors = ctx.host.temperatures()
        wanted = self.opts["sensor"]
        if wanted:
            sensors = [s for s in sensors if wanted.lower() in s.label.lower()]
        if not sensors:
            extra = f"（找不到名稱含「{wanted}」的）" if wanted else ""
            return self.result(Status.UNKNOWN, f"讀不到溫度感測器{extra}")
        hottest = max(sensors, key=lambda s: s.celsius)
        status = threshold_status(hottest.celsius, self.opts["warn"], self.opts["crit"])
        summary = f"最高 {hottest.celsius:.0f}°C（{hottest.label}）"
        if status is Status.CRIT:
            summary += "，太燙了：檢查風扇和出風口"
        return self.result(status, summary, {"max_c": round(hottest.celsius, 1)})


class UptimeCheck(Check):
    """偵測重新開機。家裡停電、跳電後，X270 會自己開回來，但你不會知道停了多久。"""

    kind = "uptime"
    label = "開機時間"
    primary = "uptime_h"
    event = True
    options = {
        # 開機不到這麼久，算是「剛重新開機」
        "recent": Opt("duration", "20m"),
    }

    def run(self, ctx: Context) -> CheckResult:
        up = ctx.host.uptime()
        if up is None:
            return self.result(Status.UNKNOWN, "讀不到開機時間")
        metrics = {"uptime_h": round(up / 3600, 2)}
        if up >= self.opts["recent"]:
            return self.result(Status.OK, f"已連續運行 {fmt_duration(up)}", metrics)
        boot = ctx.now - up
        summary = f"{fmt_duration(up)}前重新開機了"
        last = ctx.last_seen_before(boot)
        if last is not None:
            down = boot - last
            metrics["downtime_s"] = round(down)
            summary += f"，之前大約停機 {fmt_duration(down)}"
            if down > 15 * 60:
                summary += "（停電了？）"
        return self.result(Status.WARN, summary, metrics)


class ProcessCheck(Check):
    """確認某支程式還在跑，例如沒有寫成 systemd 服務的 Telegram bot。"""

    kind = "process"
    label = "行程"
    primary = "count"
    options = {
        # 在完整指令列裡搜尋的正規表示式，例如 "bot\\.py"
        "match": Opt("str"),
        "min": Opt("int", 1),
    }

    def __init__(self, name: str | None = None, confirm: int | None = None, **options: Any):
        super().__init__(name, confirm, **options)
        try:
            self.pattern = re.compile(self.opts["match"])
        except re.error as e:
            raise ConfigError(f"match 不是有效的正規表示式：{e}") from None

    def default_name(self) -> str:
        return f"行程 {self.opts['match']}"

    def ident(self) -> str:
        return str(self.opts["match"])

    def run(self, ctx: Context) -> CheckResult:
        procs = ctx.host.processes()
        if procs is None:
            return self.result(
                Status.UNKNOWN, "讀不到行程列表（Windows/macOS 需要 pip install psutil）"
            )
        me = os.getpid()
        hits = [(pid, cmd) for pid, cmd in procs if pid != me and self.pattern.search(cmd)]
        metrics = {"count": float(len(hits))}
        if len(hits) < self.opts["min"]:
            if not hits:
                return self.result(Status.CRIT, "沒有在跑", metrics)
            return self.result(
                Status.CRIT, f"只有 {len(hits)} 個（至少要 {self.opts['min']} 個）", metrics
            )
        pids = ", ".join(str(pid) for pid, _ in hits[:3])
        more = " …" if len(hits) > 3 else ""
        return self.result(Status.OK, f"{len(hits)} 個在跑（PID {pids}{more}）", metrics)
