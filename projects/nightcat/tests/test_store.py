from pathlib import Path

import pytest

from nightcat.alerts import CheckState, Transition
from nightcat.model import CheckResult, Status
from nightcat.store import Store


@pytest.fixture
def store(tmp_path: Path) -> Store:
    s = Store(tmp_path / "deep" / "dir" / "nightcat.db")
    yield s
    s.close()


def r(check_id: str, status: Status, **metrics: float) -> CheckResult:
    return CheckResult(
        check_id,
        check_id.upper(),
        "disk",
        status,
        f"{check_id} {status.value}",
        metrics,
        primary="used_pct",
    )


def test_runs_and_latest(store: Store) -> None:
    assert store.latest_results() is None and store.last_run_ts() is None
    store.record_run(100.0, [r("a", Status.OK, used_pct=10)])
    store.record_run(200.0, [r("a", Status.WARN, used_pct=90), r("b", Status.OK)])
    ts, results = store.latest_results() or (0, [])
    assert ts == 200.0
    assert [(x.check_id, x.status) for x in results] == [("a", Status.WARN), ("b", Status.OK)]
    assert results[0].metrics == {"used_pct": 90} and results[0].primary == "used_pct"
    assert store.last_run_ts() == 200.0
    assert store.last_run_before(200.0) == 100.0
    assert store.last_run_before(100.0) is None
    assert store.run_count_since(150.0) == 1
    assert store.metric_series("a", ("used_pct",), 0) == [[100.0, 10.0], [200.0, 90.0]]
    assert store.metric_series("b", ("used_pct",), 0) == []


def test_state_roundtrip(store: Store) -> None:
    s = CheckState("disk:/", Status.CRIT, 5.0, Status.OK, 1, Status.WARN, 4.0, 3.0)
    store.put_state(s)
    store.put_state(CheckState("x"))
    states = store.get_states()
    assert states["disk:/"] == s and states["x"] == CheckState("x")


def test_events(store: Store) -> None:
    store.add_event(Transition("a", "A", Status.OK, Status.CRIT, 10.0, "boom"))
    store.add_event(Transition("a", "A", Status.CRIT, Status.OK, 20.0, "fine"))
    assert [e.new for e in store.events_since(15.0)] == [Status.OK]
    assert store.events_since(0)[0].summary == "boom"


def test_outbox_keeps_newest(store: Store) -> None:
    for i in range(25):
        store.outbox_add(float(i), f"msg {i}")
    items = store.outbox_items()
    assert len(items) == 20 and items[0].text == "msg 5" and items[-1].text == "msg 24"
    store.outbox_bump(items[0].id)
    store.outbox_remove(items[1].id)
    items = store.outbox_items()
    assert items[0].attempts == 1 and len(items) == 19


def test_prune_cascades(store: Store) -> None:
    store.record_run(100.0, [r("a", Status.OK)])
    store.record_run(200.0, [r("a", Status.OK)])
    store.add_event(Transition("a", "A", Status.OK, Status.CRIT, 100.0, "old"))
    store.prune(150.0)
    assert store.run_count_since(0) == 1
    assert len(store.results_since(0)) == 1
    assert store.events_since(0) == []


def test_commit_rollback_and_readonly(tmp_path: Path) -> None:
    path = tmp_path / "n.db"
    with Store(path) as s:
        s.record_run(1.0, [r("a", Status.OK)])
        s.commit()
        s.record_run(2.0, [r("a", Status.OK)])
        s.rollback()
        s.meta_set("k", "v")
        s.commit()
    with Store(path, readonly=True) as ro:
        assert ro.last_run_ts() == 1.0
        assert ro.meta_get("k") == "v" and ro.meta_get("missing") is None
