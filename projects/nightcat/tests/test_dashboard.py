import json
import threading
import urllib.error
import urllib.request
from collections.abc import Iterator
from pathlib import Path

import pytest

from nightcat.alerts import Transition
from nightcat.config import Config, parse_config
from nightcat.dashboard import MAX_POINTS, history_payload, make_server, status_payload
from nightcat.model import CheckResult, Status
from nightcat.store import Store

NOW = 1_800_000_000.0


@pytest.fixture
def cfg(tmp_path: Path) -> Config:
    return parse_config({"nightcat": {"host_name": "X270", "data_dir": str(tmp_path / "data")}})


def seed(cfg: Config, runs: int = 3) -> None:
    with Store(cfg.db_path) as store:
        for i in range(runs):
            ts = NOW - (runs - 1 - i) * 300
            status = Status.WARN if i == runs - 1 else Status.OK
            store.record_run(
                ts,
                [
                    CheckResult(
                        "disk:/",
                        "磁碟 /",
                        "disk",
                        status,
                        f"已用 {80 + i}%",
                        {"used_pct": 80.0 + i},
                        primary="used_pct",
                    ),
                    CheckResult(
                        "uptime",
                        "開機時間",
                        "uptime",
                        Status.OK,
                        "已連續運行 5 天",
                        {"uptime_h": 120.0},
                        hint="<b>hi</b>",
                        primary="uptime_h",
                    ),
                ],
            )
        store.add_event(Transition("disk:/", "磁碟 /", Status.OK, Status.WARN, NOW, "已用 82%"))
        store.commit()


def test_status_without_data(cfg: Config) -> None:
    payload = status_payload(cfg, NOW)
    assert payload["ts"] is None and payload["results"] == [] and payload["stale"]
    assert history_payload(cfg, NOW, 24) == {}


def test_status_payload(cfg: Config) -> None:
    seed(cfg)
    payload = status_payload(cfg, NOW + 60)
    assert payload["host"] == "X270" and payload["worst"] == "warn" and payload["mood"] == "😿"
    assert payload["stale"] is False
    assert [r["id"] for r in payload["results"]] == ["disk:/", "uptime"]  # 有問題的排前面
    assert payload["events"][0]["summary"] == "已用 82%"
    assert status_payload(cfg, NOW + 3 * 3600)["stale"] is True


def test_history_payload(cfg: Config) -> None:
    seed(cfg)
    h = history_payload(cfg, NOW, 24)
    assert h["disk:/"]["primary"] == "used_pct"
    assert [p[2] for p in h["disk:/"]["points"]] == [80.0, 81.0, 82.0]
    assert h["disk:/"]["points"][-1][1] == "warn"


def test_history_is_downsampled_but_keeps_problems(cfg: Config) -> None:
    with Store(cfg.db_path) as store:
        for i in range(1000):
            status = Status.CRIT if i == 501 else Status.OK
            store.record_run(
                NOW - (1000 - i) * 60,
                [CheckResult("x", "X", "load", status, "", {"v": float(i)}, primary="v")],
            )
        store.commit()
    points = history_payload(cfg, NOW, 24)["x"]["points"]
    assert len(points) <= MAX_POINTS + 2  # 抽樣點 + 最後一點 + 那一個嚴重的點
    assert any(p[1] == "crit" for p in points)
    assert points[-1][2] == 999.0


@pytest.fixture
def server(cfg: Config) -> Iterator[str]:
    srv = make_server(cfg, "127.0.0.1", 0)
    t = threading.Thread(target=srv.serve_forever, daemon=True)
    t.start()
    yield f"http://127.0.0.1:{srv.server_address[1]}"
    srv.shutdown()
    srv.server_close()


def get(url: str) -> tuple[int, str, dict[str, str]]:
    opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
    try:
        with opener.open(url, timeout=5) as resp:
            return resp.status, resp.read().decode(), dict(resp.headers)
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode(), dict(e.headers)


def test_http_routes(cfg: Config, server: str) -> None:
    seed(cfg)
    code, body, headers = get(server + "/")
    assert code == 200 and "<title>守夜貓</title>" in body
    assert "Content-Security-Policy" in headers
    # 頁面不能有外部資源，離線也要能開
    assert "https://" not in body and "http://" not in body.replace(
        "http://www.w3.org/2000/svg", ""
    )
    code, body, _ = get(server + "/api/status")
    assert code == 200 and json.loads(body)["host"] == "X270"
    code, body, _ = get(server + "/api/history?hours=abc")
    assert code == 200 and "disk:/" in json.loads(body)
    assert get(server + "/healthz")[:2] == (200, "ok\n")
    assert get(server + "/nope")[0] == 404


def test_page_never_uses_innerhtml() -> None:
    from nightcat.dashboard import PAGE

    # 摘要、提示可能含有檔名、指令輸出，一律用 textContent 放進頁面
    assert "innerHTML" not in PAGE and "insertAdjacentHTML" not in PAGE
