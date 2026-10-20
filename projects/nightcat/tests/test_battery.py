import pytest

from conftest import FakeTree
from nightcat.checks.battery import BatteryCheck, overall_capacity
from nightcat.host import Battery
from nightcat.model import Status


def _thinkpad(
    tree: FakeTree,
    *,
    ac: bool,
    capacity: int = 80,
    health_full: int = 18000000,
    threshold: int | None = 100,
) -> None:
    tree.ac(ac)
    attrs: dict[str, object] = {
        "status": "Discharging" if not ac else "Not charging",
        "capacity": capacity,
        "energy_full_design": 24000000,
        "energy_full": health_full,
        "energy_now": int(health_full * capacity / 100),
    }
    if threshold is not None:
        attrs["charge_control_end_threshold"] = threshold
    tree.battery("BAT0", **attrs)


def test_plugged_in_and_healthy(tree: FakeTree) -> None:
    _thinkpad(tree, ac=True, threshold=80)
    r = BatteryCheck().run(tree.ctx())
    assert r.status is Status.OK
    assert "插電中" in r.summary and "健康度 75%" in r.summary
    assert r.metrics == {"on_battery": 0.0, "capacity": 80.0, "health": 75.0}
    assert r.hint is None


def test_threshold_hint(tree: FakeTree) -> None:
    _thinkpad(tree, ac=True, threshold=100)
    r = BatteryCheck().run(tree.ctx())
    assert r.status is Status.OK
    assert (
        r.hint
        and "echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold" in r.hint
    )


def test_no_threshold_support_suggests_tlp(tree: FakeTree) -> None:
    _thinkpad(tree, ac=True, threshold=None)
    r = BatteryCheck().run(tree.ctx())
    assert r.hint and "TLP" in r.hint


def test_power_outage(tree: FakeTree) -> None:
    _thinkpad(tree, ac=False, capacity=63)
    r = BatteryCheck().run(tree.ctx())
    assert r.status is Status.WARN and "停電" in r.summary and "63%" in r.summary
    assert r.metrics["on_battery"] == 1.0
    assert BatteryCheck(on_battery="crit").run(tree.ctx()).status is Status.CRIT


def test_power_outage_battery_low(tree: FakeTree) -> None:
    _thinkpad(tree, ac=False, capacity=18)
    r = BatteryCheck().run(tree.ctx())
    assert r.status is Status.CRIT and "只剩 18%" in r.summary


def test_worn_battery(tree: FakeTree) -> None:
    _thinkpad(tree, ac=True, health_full=9600000, threshold=80)
    r = BatteryCheck().run(tree.ctx())
    assert r.status is Status.WARN and "健康度只剩 40%" in r.summary and "BAT0" in r.summary


def test_discharging_status_without_ac_info(tree: FakeTree) -> None:
    tree.battery("BAT0", status="Discharging", capacity=50)
    assert BatteryCheck().run(tree.ctx()).status is Status.WARN


def test_no_battery(tree: FakeTree) -> None:
    tree.ac(True)
    r = BatteryCheck().run(tree.ctx())
    assert r.status is Status.UNKNOWN and "找不到電池" in r.summary
    assert BatteryCheck().run(FakeTree(tree.root / "empty").ctx()).status is Status.UNKNOWN


def test_overall_capacity_weighs_by_energy() -> None:
    small_full = Battery("BAT0", 100, "Full", energy_now=20, energy_full=20)
    big_empty = Battery("BAT1", 10, "Discharging", energy_now=8, energy_full=80)
    assert overall_capacity([small_full, big_empty]) == pytest.approx(28.0)
    assert overall_capacity([Battery("a", 50, "Full"), Battery("b", 70, "Full")]) == 60.0
    assert overall_capacity([]) is None
