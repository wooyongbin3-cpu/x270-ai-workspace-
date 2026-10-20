from pathlib import Path

import pytest

from conftest import NOON, FakeTree
from nightcat.checks.system import (
    DiskCheck,
    LoadCheck,
    MemoryCheck,
    ProcessCheck,
    TemperatureCheck,
    UptimeCheck,
)
from nightcat.host import DiskUsage, Host
from nightcat.model import Status

GB = 1024**3


def _fake_disk(monkeypatch: pytest.MonkeyPatch, used: float, free: float) -> None:
    monkeypatch.setattr(
        Host,
        "disk_usage",
        lambda self, path: DiskUsage(int((used + free) * GB), int(used * GB), int(free * GB)),
    )


@pytest.mark.parametrize(
    ("used", "status"), [(50, Status.OK), (86, Status.WARN), (96, Status.CRIT)]
)
def test_disk_thresholds(
    tree: FakeTree, monkeypatch: pytest.MonkeyPatch, tmp_path: Path, used: float, status: Status
) -> None:
    _fake_disk(monkeypatch, used, 100 - used)
    r = DiskCheck(path=str(tmp_path)).run(tree.ctx())
    assert r.status is status
    assert r.metrics["used_pct"] == pytest.approx(used)
    assert f"已用 {used:.0f}%" in r.summary
    assert r.check_id == f"disk:{tmp_path}"


def test_disk_min_free(tree: FakeTree, monkeypatch: pytest.MonkeyPatch, tmp_path: Path) -> None:
    _fake_disk(monkeypatch, 10, 0.5)
    r = DiskCheck(path=str(tmp_path), min_free="1GB").run(tree.ctx())
    assert r.status is Status.CRIT


def test_disk_missing_or_unmounted(tree: FakeTree, tmp_path: Path) -> None:
    r = DiskCheck(path=str(tmp_path / "nope")).run(tree.ctx())
    assert r.status is Status.CRIT and "不存在" in r.summary
    r = DiskCheck(path=str(tmp_path), must_be_mount=True).run(tree.ctx())
    assert r.status is Status.CRIT and "沒有掛載" in r.summary


@pytest.mark.parametrize(
    ("avail", "status"), [(5000, Status.OK), (800, Status.WARN), (200, Status.CRIT)]
)
def test_memory(tree: FakeTree, avail: int, status: Status) -> None:
    tree.meminfo(10000, avail)
    r = MemoryCheck().run(tree.ctx())
    assert r.status is status
    assert r.check_id == "memory"


def test_memory_swap_warn(tree: FakeTree) -> None:
    tree.meminfo(10000, 5000, swap_total_kb=1000, swap_free_kb=100)
    r = MemoryCheck(swap_warn=80).run(tree.ctx())
    assert r.status is Status.WARN and "swap" in r.summary
    assert r.metrics["swap_pct"] == 90.0


def test_memory_unknown(tree: FakeTree) -> None:
    assert MemoryCheck().run(tree.ctx()).status is Status.UNKNOWN


@pytest.mark.parametrize(
    ("load5", "status"), [("2.00", Status.OK), ("6.40", Status.WARN), ("12.5", Status.CRIT)]
)
def test_load_is_per_cpu(tree: FakeTree, load5: str, status: Status) -> None:
    tree.write("proc/loadavg", f"0.1 {load5} 0.1 1/1 1")
    tree.write("proc/cpuinfo", "processor: 0\nprocessor: 1\nprocessor: 2\nprocessor: 3\n")
    r = LoadCheck().run(tree.ctx())
    assert r.status is status
    assert r.metrics["per_cpu"] == pytest.approx(float(load5) / 4, abs=1e-3)


def test_temperature(tree: FakeTree) -> None:
    tree.write("sys/class/thermal/thermal_zone0/type", "x86_pkg_temp")
    tree.write("sys/class/thermal/thermal_zone0/temp", "95000")
    tree.write("sys/class/thermal/thermal_zone1/type", "acpitz")
    tree.write("sys/class/thermal/thermal_zone1/temp", "50000")
    r = TemperatureCheck().run(tree.ctx())
    assert r.status is Status.CRIT and "95°C" in r.summary and "風扇" in r.summary
    r = TemperatureCheck(sensor="acpi").run(tree.ctx())
    assert r.status is Status.OK and r.metrics["max_c"] == 50.0
    assert r.check_id == "temperature:acpi"
    r = TemperatureCheck(sensor="gpu").run(tree.ctx())
    assert r.status is Status.UNKNOWN and "gpu" in r.summary


def test_uptime_ok(tree: FakeTree) -> None:
    tree.write("proc/uptime", str(3 * 86400 + 7200))
    r = UptimeCheck().run(tree.ctx())
    assert r.status is Status.OK and "3 天 2 小時" in r.summary
    assert r.event


def test_uptime_recent_reboot_reports_downtime(tree: FakeTree) -> None:
    tree.write("proc/uptime", "300")
    boot = NOON - 300
    seen: list[float] = []

    def last_seen(ts: float) -> float | None:
        seen.append(ts)
        return boot - 2 * 3600

    r = UptimeCheck().run(tree.ctx(last_seen=last_seen))
    assert r.status is Status.WARN
    assert seen == [boot]
    assert "5 分鐘前重新開機" in r.summary and "2 小時" in r.summary and "停電" in r.summary
    assert r.metrics["downtime_s"] == 7200


def test_uptime_without_history(tree: FakeTree) -> None:
    tree.write("proc/uptime", "60")
    r = UptimeCheck().run(tree.ctx())
    assert r.status is Status.WARN and "停機" not in r.summary


def test_process(tree: FakeTree) -> None:
    tree.write("proc/meminfo", "MemTotal: 1 kB\n")
    tree.write("proc/990001/cmdline", "python3\0/home/yb/bot.py\0")
    tree.write("proc/990002/cmdline", "nginx\0")
    assert ProcessCheck(match=r"bot\.py").run(tree.ctx()).status is Status.OK
    r = ProcessCheck(match="telegram").run(tree.ctx())
    assert r.status is Status.CRIT and r.summary == "沒有在跑"
    r = ProcessCheck(match="python|nginx", min=3).run(tree.ctx())
    assert r.status is Status.CRIT and "只有 2 個" in r.summary
