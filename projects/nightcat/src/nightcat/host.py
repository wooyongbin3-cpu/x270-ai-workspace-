"""讀取這台機器的狀態。

Linux 上直接讀 /proc 與 /sys（只用標準庫）；沒有 procfs 的系統（Windows、macOS）
會改用 psutil，前提是有安裝。`root` 參數讓測試可以指向一棵假的 /proc、/sys 目錄樹。
"""

from __future__ import annotations

import os
import shutil
import subprocess
import time
from collections.abc import Sequence
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

_AUTO: Any = object()

# init 自動偵測磁碟時會列出的檔案系統
REAL_FILESYSTEMS = {
    "ext2", "ext3", "ext4", "xfs", "btrfs", "f2fs", "zfs",
    "vfat", "exfat", "ntfs", "ntfs3", "fuseblk",
}  # fmt: skip
_SKIP_MOUNT_PREFIXES = ("/boot", "/snap", "/var/lib/docker", "/run", "/sys", "/proc", "/dev")


def _load_psutil() -> Any:
    try:
        import psutil
    except ImportError:
        return None
    return psutil


@dataclass
class Memory:
    total: int
    available: int
    swap_total: int = 0
    swap_free: int = 0


@dataclass
class Load:
    one: float
    five: float
    fifteen: float
    cpus: int
    # "loadavg"：真正的 Unix 平均負載；"cpu_percent"：Windows 上用 CPU 使用率換算
    source: str = "loadavg"


@dataclass
class Sensor:
    label: str
    celsius: float


@dataclass
class Battery:
    name: str
    capacity: float | None
    status: str
    health: float | None = None
    energy_now: float | None = None
    energy_full: float | None = None
    cycle_count: int | None = None
    threshold: int | None = None
    threshold_path: str | None = None


@dataclass
class Power:
    batteries: list[Battery] = field(default_factory=list)
    ac_online: bool | None = None
    source: str = "sysfs"


@dataclass
class CommandResult:
    returncode: int
    stdout: str
    stderr: str


@dataclass
class DiskUsage:
    total: int
    used: int
    free: int


class Host:
    def __init__(self, root: str | os.PathLike[str] = "/", psutil: Any = _AUTO) -> None:
        self.root = Path(root)
        self.psutil = _load_psutil() if psutil is _AUTO else psutil

    # ---------- 小工具 ----------

    def path(self, rel: str) -> Path:
        return self.root / rel.lstrip("/")

    def read_text(self, rel: str | Path) -> str | None:
        p = rel if isinstance(rel, Path) else self.path(rel)
        try:
            return p.read_text(encoding="utf-8", errors="replace").strip()
        except OSError:
            return None

    def read_number(self, rel: str | Path) -> float | None:
        text = self.read_text(rel)
        if text is None:
            return None
        try:
            return float(text.split()[0])
        except (ValueError, IndexError):
            return None

    @property
    def has_procfs(self) -> bool:
        return self.path("proc/meminfo").exists()

    # ---------- 記憶體 / 負載 / 開機時間 ----------

    def memory(self) -> Memory | None:
        text = self.read_text("proc/meminfo")
        if text:
            info: dict[str, int] = {}
            for line in text.splitlines():
                key, _, rest = line.partition(":")
                parts = rest.split()
                if parts and parts[0].isdigit():
                    factor = 1024 if len(parts) > 1 and parts[1].lower() == "kb" else 1
                    info[key.strip()] = int(parts[0]) * factor
            total = info.get("MemTotal")
            if not total:
                return None
            available = info.get("MemAvailable")
            if available is None:  # 很舊的 kernel 沒有 MemAvailable
                available = info.get("MemFree", 0) + info.get("Buffers", 0) + info.get("Cached", 0)
            return Memory(total, available, info.get("SwapTotal", 0), info.get("SwapFree", 0))
        if self.psutil is not None:
            vm = self.psutil.virtual_memory()
            sw = self.psutil.swap_memory()
            return Memory(int(vm.total), int(vm.available), int(sw.total), int(sw.free))
        return None

    def cpu_count(self) -> int:
        text = self.read_text("proc/cpuinfo")
        if text:
            n = sum(1 for line in text.splitlines() if line.startswith("processor"))
            if n:
                return n
        if self.root == Path("/"):
            return os.cpu_count() or 1
        return 1

    def load(self) -> Load | None:
        cpus = self.cpu_count()
        text = self.read_text("proc/loadavg")
        if text:
            try:
                one, five, fifteen = (float(x) for x in text.split()[:3])
            except ValueError:
                return None
            return Load(one, five, fifteen, cpus)
        if self.root == Path("/") and hasattr(os, "getloadavg"):
            one, five, fifteen = os.getloadavg()
            return Load(one, five, fifteen, cpus)
        if self.psutil is not None:
            # Windows 沒有平均負載；用 1 秒的 CPU 使用率換算成「等效負載」
            pct = float(self.psutil.cpu_percent(interval=1.0))
            approx = pct / 100 * cpus
            return Load(approx, approx, approx, cpus, source="cpu_percent")
        return None

    def uptime(self) -> float | None:
        value = self.read_number("proc/uptime")
        if value is not None:
            return value
        if self.psutil is not None:
            return max(0.0, time.time() - float(self.psutil.boot_time()))
        return None

    # ---------- 溫度 ----------

    def temperatures(self) -> list[Sensor]:
        sensors: list[Sensor] = []
        for zone in sorted(self.path("sys/class/thermal").glob("thermal_zone*")):
            milli = self.read_number(zone / "temp")
            if milli is not None:
                sensors.append(Sensor(self.read_text(zone / "type") or zone.name, milli / 1000))
        for hw in sorted(self.path("sys/class/hwmon").glob("hwmon*")):
            chip = self.read_text(hw / "name") or hw.name
            for f in sorted(hw.glob("temp*_input")):
                milli = self.read_number(f)
                if milli is None:
                    continue
                label = self.read_text(hw / f.name.replace("_input", "_label")) or f.name[:-6]
                sensors.append(Sensor(f"{chip}/{label}", milli / 1000))
        if not sensors and self.psutil is not None and hasattr(self.psutil, "sensors_temperatures"):
            try:
                groups = self.psutil.sensors_temperatures()
            except Exception:  # 有些平台會直接丟例外
                groups = {}
            for chip, entries in groups.items():
                for e in entries:
                    sensors.append(Sensor(f"{chip}/{e.label or 'temp'}", float(e.current)))
        # 有些感測器會回報 0 或離譜的數字，丟掉
        return [s for s in sensors if 0 < s.celsius < 150]

    # ---------- 電池 / 電源 ----------

    def power(self) -> Power | None:
        base = self.path("sys/class/power_supply")
        if base.is_dir():
            return self._power_sysfs(base)
        if self.psutil is not None and hasattr(self.psutil, "sensors_battery"):
            b = self.psutil.sensors_battery()
            if b is None:
                return Power([], None, "psutil")
            plugged = b.power_plugged
            if plugged is None:
                status = "Unknown"
            elif not plugged:
                status = "Discharging"
            else:
                status = "Full" if b.percent >= 100 else "Charging"
            return Power([Battery("battery", float(b.percent), status)], plugged, "psutil")
        return None

    def _power_sysfs(self, base: Path) -> Power:
        power = Power()
        for dev in sorted(base.iterdir()):
            kind = self.read_text(dev / "type")
            if kind == "Mains":
                online = self.read_number(dev / "online")
                if online is not None:
                    power.ac_online = bool(power.ac_online) or online == 1
            elif kind == "Battery":
                if self.read_text(dev / "scope") == "Device":  # 滑鼠、藍牙耳機之類的電池
                    continue
                if self.read_number(dev / "present") == 0:
                    continue
                power.batteries.append(self._battery(dev))
        return power

    def _battery(self, dev: Path) -> Battery:
        def num(name: str) -> float | None:
            return self.read_number(dev / name)

        prefix = "energy" if num("energy_full_design") is not None else "charge"
        full, design = num(f"{prefix}_full"), num(f"{prefix}_full_design")
        health = full / design * 100 if full and design else None
        threshold = threshold_path = None
        for attr in ("charge_control_end_threshold", "charge_stop_threshold"):
            value = num(attr)
            if value is not None:
                threshold, threshold_path = (
                    int(value),
                    "/" + str((dev / attr).relative_to(self.root)),
                )
                break
        cycles = num("cycle_count")
        return Battery(
            name=dev.name,
            capacity=num("capacity"),
            status=self.read_text(dev / "status") or "Unknown",
            health=health,
            energy_now=num(f"{prefix}_now"),
            energy_full=full,
            cycle_count=int(cycles) if cycles else None,
            threshold=threshold,
            threshold_path=threshold_path,
        )

    # ---------- 行程 ----------

    def processes(self) -> list[tuple[int, str]] | None:
        proc = self.path("proc")
        if self.has_procfs:
            found: list[tuple[int, str]] = []
            for d in proc.iterdir():
                if not d.name.isdigit():
                    continue
                try:
                    raw = (d / "cmdline").read_bytes()
                except OSError:
                    continue
                cmd = raw.replace(b"\0", b" ").decode("utf-8", "replace").strip()
                if not cmd:
                    comm = self.read_text(d / "comm")
                    cmd = f"[{comm}]" if comm else ""
                found.append((int(d.name), cmd))
            return found
        if self.psutil is not None:
            found = []
            for p in self.psutil.process_iter(["pid", "cmdline", "name"]):
                cmdline = p.info.get("cmdline") or []
                found.append((int(p.info["pid"]), " ".join(cmdline) or f"[{p.info.get('name')}]"))
            return found
        return None

    # ---------- 磁碟 ----------

    def disk_usage(self, path: str) -> DiskUsage:
        u = shutil.disk_usage(path)
        return DiskUsage(u.total, u.used, u.free)

    def is_mount(self, path: str) -> bool:
        return os.path.ismount(path)

    def mounts(self) -> list[str]:
        """真實磁碟的掛載點（給 init 自動產生設定用）。"""
        text = self.read_text("proc/mounts")
        if not text:
            return ["/"] if os.name != "nt" else [os.environ.get("SYSTEMDRIVE", "C:") + "\\"]
        found: list[str] = []
        for line in text.splitlines():
            parts = line.split()
            if len(parts) < 3:
                continue
            mountpoint = parts[1].replace("\\040", " ").replace("\\011", "\t")
            if parts[2] not in REAL_FILESYSTEMS:
                continue
            if mountpoint != "/" and mountpoint.startswith(_SKIP_MOUNT_PREFIXES):
                continue
            if mountpoint not in found:
                found.append(mountpoint)
        return found or ["/"]

    def has_systemd(self) -> bool:
        return self.path("run/systemd/system").is_dir()

    # ---------- 外部指令 ----------

    def run(self, argv: Sequence[str], timeout: float) -> CommandResult:
        """執行指令並收集輸出。找不到指令會丟 FileNotFoundError，逾時丟 TimeoutExpired。"""
        proc = subprocess.run(
            list(argv),
            capture_output=True,
            text=True,
            errors="replace",
            timeout=timeout,
            stdin=subprocess.DEVNULL,
            creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
        )
        return CommandResult(proc.returncode, proc.stdout, proc.stderr)
