from __future__ import annotations

import json
import threading
from collections.abc import Callable, Iterator
from datetime import datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import Any

import pytest

from nightcat.checks import Context
from nightcat.host import Host

# 固定的「現在」：2026-10-20 12:00（本地時間），避免測試結果跟著時鐘跑
NOON = datetime(2026, 10, 20, 12, 0).timestamp()


class FakeTree:
    """一棵假的 /proc + /sys，讓 Host 讀它而不是真的系統。"""

    def __init__(self, root: Path) -> None:
        self.root = root

    def write(self, rel: str, content: object) -> FakeTree:
        p = self.root / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(str(content))
        return self

    def meminfo(
        self, total_kb: int, available_kb: int, swap_total_kb: int = 0, swap_free_kb: int = 0
    ) -> FakeTree:
        return self.write(
            "proc/meminfo",
            f"MemTotal: {total_kb} kB\nMemFree: 1 kB\nMemAvailable: {available_kb} kB\n"
            f"SwapTotal: {swap_total_kb} kB\nSwapFree: {swap_free_kb} kB\n",
        )

    def battery(self, name: str = "BAT0", **attrs: object) -> FakeTree:
        defaults: dict[str, object] = {
            "type": "Battery",
            "present": 1,
            "status": "Full",
            "capacity": 80,
        }
        for key, value in {**defaults, **attrs}.items():
            self.write(f"sys/class/power_supply/{name}/{key}", value)
        return self

    def ac(self, online: bool, name: str = "AC") -> FakeTree:
        self.write(f"sys/class/power_supply/{name}/type", "Mains")
        return self.write(f"sys/class/power_supply/{name}/online", int(online))

    def host(self) -> Host:
        return Host(self.root, psutil=None)

    def ctx(
        self, now: float = NOON, last_seen: Callable[[float], float | None] | None = None
    ) -> Context:
        ctx = Context(self.host(), now)
        if last_seen is not None:
            ctx.last_seen_before = last_seen
        return ctx


@pytest.fixture(autouse=True)
def _isolated_env(monkeypatch: pytest.MonkeyPatch, tmp_path: Path) -> None:
    """測試不能讀到真的設定檔、真的 token，也不能寫進真的家目錄。"""
    for key in ("NIGHTCAT_TELEGRAM_TOKEN", "NIGHTCAT_TELEGRAM_CHAT_ID", "NIGHTCAT_CONFIG"):
        monkeypatch.delenv(key, raising=False)
    monkeypatch.setenv("XDG_CONFIG_HOME", str(tmp_path / "xdg-config"))
    monkeypatch.setenv("XDG_DATA_HOME", str(tmp_path / "xdg-data"))


@pytest.fixture
def tree(tmp_path: Path) -> FakeTree:
    root = tmp_path / "root"
    root.mkdir()
    return FakeTree(root)


class Recorder(BaseHTTPRequestHandler):
    """可以設定回應的小 HTTP 伺服器，也順便記錄收到的請求。"""

    routes: dict[str, tuple[int, str]] = {}
    received: list[dict[str, Any]] = []

    def do_GET(self) -> None:
        self._reply()

    def do_POST(self) -> None:
        length = int(self.headers.get("Content-Length", 0))
        self.received.append({"path": self.path, "body": self.rfile.read(length).decode()})
        self._reply()

    def _reply(self) -> None:
        code, body = self.routes.get(self.path.split("?")[0], (404, "nope"))
        data = body.encode()
        self.send_response(code)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def log_message(self, *args: Any) -> None:
        pass


class LocalServer:
    def __init__(self) -> None:
        handler = type("H", (Recorder,), {"routes": {}, "received": []})
        self.handler = handler
        self.server = ThreadingHTTPServer(("127.0.0.1", 0), handler)
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)

    @property
    def url(self) -> str:
        return f"http://127.0.0.1:{self.server.server_address[1]}"

    def route(self, path: str, code: int = 200, body: str | dict[str, Any] = "ok") -> None:
        self.handler.routes[path] = (code, body if isinstance(body, str) else json.dumps(body))

    @property
    def received(self) -> list[dict[str, Any]]:
        return self.handler.received


@pytest.fixture
def http_server() -> Iterator[LocalServer]:
    srv = LocalServer()
    srv.thread.start()
    yield srv
    srv.server.shutdown()
    srv.server.server_close()


@pytest.fixture
def free_port() -> int:
    import socket

    with socket.socket() as s:
        s.bind(("127.0.0.1", 0))
        return int(s.getsockname()[1])
