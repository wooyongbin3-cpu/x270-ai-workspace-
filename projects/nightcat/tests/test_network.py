import socket

from conftest import FakeTree, LocalServer
from nightcat.checks.network import HttpCheck, TcpCheck
from nightcat.model import Status


def test_http_ok(tree: FakeTree, http_server: LocalServer) -> None:
    http_server.route("/health", 200, '{"ok": true}')
    r = HttpCheck(url=http_server.url + "/health", contains='"ok"').run(tree.ctx())
    assert r.status is Status.OK and r.summary.startswith("HTTP 200")
    assert r.metrics["http_status"] == 200 and r.metrics["latency_ms"] >= 0
    assert r.check_id == f"http:{http_server.url}/health"


def test_http_error_status(tree: FakeTree, http_server: LocalServer) -> None:
    http_server.route("/health", 502, "bad gateway")
    r = HttpCheck(url=http_server.url + "/health").run(tree.ctx())
    assert r.status is Status.CRIT and "HTTP 502" in r.summary and "2xx/3xx" in r.summary


def test_http_expected_status(tree: FakeTree, http_server: LocalServer) -> None:
    http_server.route("/auth", 401, "login first")
    assert (
        HttpCheck(url=http_server.url + "/auth", expect_status=[200, 401]).run(tree.ctx()).status
        is Status.OK
    )
    assert (
        HttpCheck(url=http_server.url + "/auth", expect_status=200).run(tree.ctx()).status
        is Status.CRIT
    )


def test_http_missing_content(tree: FakeTree, http_server: LocalServer) -> None:
    http_server.route("/", 200, "maintenance")
    r = HttpCheck(url=http_server.url + "/", contains="喵帳本").run(tree.ctx())
    assert r.status is Status.CRIT and "喵帳本" in r.summary


def test_http_slow(tree: FakeTree, http_server: LocalServer) -> None:
    http_server.route("/", 200, "ok")
    r = HttpCheck(url=http_server.url + "/", warn_ms=0).run(tree.ctx())
    assert r.status is Status.WARN and "很慢" in r.summary


def test_http_refused(tree: FakeTree, free_port: int) -> None:
    r = HttpCheck(url=f"http://127.0.0.1:{free_port}/", timeout=2).run(tree.ctx())
    assert r.status is Status.CRIT and "連線被拒絕" in r.summary


def test_http_timeout(tree: FakeTree) -> None:
    # 只 listen 不 accept：連線會建立，但永遠等不到回應
    with socket.socket() as s:
        s.bind(("127.0.0.1", 0))
        s.listen(1)
        r = HttpCheck(url=f"http://127.0.0.1:{s.getsockname()[1]}/", timeout=0.3).run(tree.ctx())
    assert r.status is Status.CRIT and "逾時" in r.summary


def test_http_defaults_need_two_failures() -> None:
    assert HttpCheck(url="http://x").confirm == 2
    assert HttpCheck(url="http://x", confirm=1).confirm == 1


def test_tcp(tree: FakeTree, http_server: LocalServer, free_port: int) -> None:
    port = http_server.server.server_address[1]
    r = TcpCheck(port=port).run(tree.ctx())
    assert r.status is Status.OK and f"127.0.0.1:{port}" in r.summary
    r = TcpCheck(port=free_port, timeout=1).run(tree.ctx())
    assert r.status is Status.CRIT and "拒絕" in r.summary
    assert TcpCheck(host="1.1.1.1", port=53).check_id == "tcp:1.1.1.1:53"
