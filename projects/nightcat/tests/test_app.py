"""整個流程的模擬：用假的 /proc、/sys 模擬一晚上的狀況，看守夜貓的反應對不對。"""

from datetime import datetime
from pathlib import Path

import pytest

from conftest import FakeTree
from nightcat.app import run_once
from nightcat.checks import build_checks
from nightcat.config import Config, parse_config
from nightcat.host import DiskUsage, Host
from nightcat.report import build_report, disk_forecast, report_due
from nightcat.store import Store

GB = 1024**3


class Inbox:
    def __init__(self) -> None:
        self.messages: list[str] = []

    def send(self, text: str) -> None:
        self.messages.append(text)


def at(hour: int, minute: int = 0, day: int = 20) -> float:
    return datetime(2026, 10, day, hour, minute).timestamp()


@pytest.fixture
def setup(tree: FakeTree, tmp_path: Path) -> tuple[Config, FakeTree]:
    tree.meminfo(8_000_000, 4_000_000)
    tree.write("proc/uptime", str(5 * 86400))
    tree.ac(True)
    tree.battery("BAT0", status="Full", capacity=80, energy_full_design=100, energy_full=90, energy_now=72,
                 charge_control_end_threshold=80)  # fmt: skip
    cfg = parse_config(
        {
            "nightcat": {
                "host_name": "X270",
                "data_dir": str(tmp_path / "data"),
                "quiet_hours": "23:30-07:00",
                "daily_report": "08:00",
            },
            "check": [{"type": "memory"}, {"type": "battery"}, {"type": "uptime"}],
        }
    )
    return cfg, tree


def go(cfg: Config, tree: FakeTree, now: float, inbox: Inbox):  # type: ignore[no-untyped-def]
    with Store(cfg.db_path) as store:
        out = run_once(cfg, build_checks(cfg.checks), store, tree.host(), inbox, now)
        store.commit()
    return out


def test_quiet_night_sends_only_the_morning_report(setup: tuple[Config, FakeTree]) -> None:
    cfg, tree = setup
    inbox = Inbox()
    for hour in (22, 23, 2, 6):
        out = go(cfg, tree, at(hour, day=20 if hour >= 22 else 21), inbox)
        assert out.notices == []
    assert inbox.messages == []
    out = go(cfg, tree, at(8, 5, day=21), inbox)
    assert out.report is not None
    (report,) = inbox.messages
    assert report.startswith("☀️ X270 日報 · 10/21（三）")
    assert "😺 全部正常" in report and "一切平靜" in report
    # 同一天不會再送第二份
    go(cfg, tree, at(9, day=21), inbox)
    assert len(inbox.messages) == 1


def test_power_outage_overnight(setup: tuple[Config, FakeTree]) -> None:
    cfg, tree = setup
    inbox = Inbox()
    go(cfg, tree, at(1, 0, day=21), inbox)

    # 01:30 停電：用電池供電。「注意」等級，半夜不吵
    tree.ac(False)
    tree.write("sys/class/power_supply/BAT0/status", "Discharging")
    tree.write("sys/class/power_supply/BAT0/energy_now", 40)
    out = go(cfg, tree, at(1, 30, day=21), inbox)
    assert out.notices == [] and [t.new.value for t in out.transitions] == ["warn"]

    # 02:10 電量剩 20%：嚴重，就算是半夜也要叫
    tree.write("sys/class/power_supply/BAT0/energy_now", 18)
    out = go(cfg, tree, at(2, 10, day=21), inbox)
    assert len(inbox.messages) == 1 and "只剩 20%" in inbox.messages[0]

    # 04:40 電來了，機器重新開機（5 分鐘前），恢復通知照送（之前是嚴重）
    tree.ac(True)
    tree.write("sys/class/power_supply/BAT0/status", "Charging")
    tree.write("proc/uptime", "300")
    out = go(cfg, tree, at(4, 40, day=21), inbox)
    assert len(inbox.messages) == 2 and "恢復正常" in inbox.messages[1]
    # 重新開機是「注意」等級的事件，半夜先不講
    assert "重新開機" not in inbox.messages[1]

    # 08:00 日報裡要看得到整晚發生的事，包括停機多久
    tree.write("proc/uptime", str(3 * 3600 + 300))
    go(cfg, tree, at(8, 0, day=21), inbox)
    report = inbox.messages[-1]
    assert "【過去 24 小時】" in report
    assert (
        "01:30 🟡 電池" in report
        and "02:10 🔴 電池" in report
        and "04:40 🟢 電池 恢復正常" in report
    )
    assert "04:40 🟡 開機時間" in report and "停機 2 小時 25 分" in report


def test_daily_report_contents(
    tree: FakeTree, tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    used = {"value": 50 * GB}
    monkeypatch.setattr(
        Host,
        "disk_usage",
        lambda self, p: DiskUsage(100 * GB, used["value"], 100 * GB - used["value"]),
    )
    tree.battery("BAT0", capacity=90, charge_control_end_threshold=100)
    tree.ac(True)
    cfg = parse_config(
        {
            "nightcat": {"host_name": "X270", "data_dir": str(tmp_path / "d")},
            "check": [{"type": "disk", "path": str(tmp_path)}, {"type": "battery"}],
        }
    )
    inbox = Inbox()
    # 一天 4 GB 的速度在長
    for i in range(8):
        used["value"] = int((50 + i * 1) * GB)
        go(cfg, tree, at(0, 0, day=10) + i * 6 * 3600, inbox)
    with Store(cfg.db_path) as store:
        latest = store.latest_results()
        assert latest is not None
        results = build_checks(cfg.checks)
        from nightcat.checks import Context
        from nightcat.runner import run_checks

        now = at(0, 0, day=10) + 7 * 6 * 3600
        report = build_report(
            cfg.host_name, run_checks(results, Context(tree.host(), now)), store, now
        )
    assert "照目前速度約 11 天後會滿" in report
    assert "⚠️" in report and "該清一清了" in report
    assert "💡" in report and "sudo tee" in report


def test_disk_forecast() -> None:
    day = 86400.0
    assert disk_forecast([[0, 10, 90], [day, 20, 80]]) is None  # 點太少
    assert disk_forecast([[0, 10, 90], [100, 20, 80], [200, 30, 70]]) is None  # 時間太短
    assert disk_forecast([[0, 10, 90], [day, 20, 80], [2 * day, 30, 70]]) == pytest.approx(7.0)
    assert disk_forecast([[0, 30, 70], [day, 20, 80], [2 * day, 10, 90]]) is None  # 在變少


def test_report_due(tmp_path: Path) -> None:
    from datetime import time

    with Store(tmp_path / "n.db") as store:
        assert not report_due(None, store, at(9))
        assert not report_due(time(8, 0), store, at(7, 59))
        assert report_due(time(8, 0), store, at(8, 0))
        store.meta_set("last_report", "2026-10-20")
        assert not report_due(time(8, 0), store, at(23))
        assert report_due(time(8, 0), store, at(8, 0, day=21))


def test_crashing_check_does_not_break_the_run(
    setup: tuple[Config, FakeTree], monkeypatch: pytest.MonkeyPatch
) -> None:
    cfg, tree = setup

    def boom(self: Host) -> None:
        raise RuntimeError("sensor exploded")

    monkeypatch.setattr(Host, "memory", boom)
    out = go(cfg, tree, at(12), Inbox())
    by_id = {r.check_id: r for r in out.results}
    assert (
        by_id["memory"].status.value == "unknown" and "sensor exploded" in by_id["memory"].summary
    )
    assert by_id["battery"].status.value == "ok"
