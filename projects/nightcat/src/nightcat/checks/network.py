"""網路服務：HTTP 健康檢查與 TCP 連線。"""

from __future__ import annotations

import socket
import ssl
import time
import urllib.error
import urllib.parse
import urllib.request

from .. import __version__
from ..model import CheckResult, Status
from .base import Check, Context, Opt

_BODY_LIMIT = 1024 * 1024
_LOCAL_HOSTS = {"localhost", "127.0.0.1", "::1"}


def _opener_for(url: str) -> urllib.request.OpenerDirector:
    """本機的服務不走代理：環境裡設了 HTTP_PROXY 時，打 127.0.0.1 也會被送去代理。"""
    host = (urllib.parse.urlsplit(url).hostname or "").lower()
    if host in _LOCAL_HOSTS or host.startswith("127."):
        return urllib.request.build_opener(urllib.request.ProxyHandler({}))
    return urllib.request.build_opener()


def describe_error(err: BaseException, timeout: float) -> str:
    """把網路例外翻成看得懂的中文。"""
    reason: object = err.reason if isinstance(err, urllib.error.URLError) else err
    if isinstance(reason, (socket.timeout, TimeoutError)):
        return f"逾時（{timeout:g} 秒沒回應）"
    if isinstance(reason, ConnectionRefusedError):
        return "連線被拒絕（服務沒在跑？）"
    if isinstance(reason, socket.gaierror):
        return "找不到這個主機名稱（DNS 或網址打錯？）"
    if isinstance(reason, ssl.SSLCertVerificationError):
        return f"HTTPS 憑證有問題：{reason.verify_message}"
    if isinstance(reason, ssl.SSLError):
        return f"HTTPS 連線失敗：{reason}"
    if isinstance(reason, OSError) and reason.strerror:
        return f"連不上：{reason.strerror}"
    return f"連不上：{reason}"


class HttpCheck(Check):
    kind = "http"
    label = "網站"
    primary = "latency_ms"
    # 網路偶爾會抖一下，連續兩次失敗才通知
    default_confirm = 2
    options = {
        "url": Opt("str"),
        # 空的話 2xx、3xx 都算正常
        "expect_status": Opt("ints", None),
        "contains": Opt("str", None),
        "timeout": Opt("num", 10),
        "warn_ms": Opt("num", None),
        "method": Opt("str", "GET"),
    }

    def default_name(self) -> str:
        return str(self.opts["url"])

    def ident(self) -> str:
        return str(self.opts["url"])

    def run(self, ctx: Context) -> CheckResult:
        url: str = self.opts["url"]
        timeout: float = self.opts["timeout"]
        req = urllib.request.Request(
            url,
            method=self.opts["method"].upper(),
            headers={"User-Agent": f"nightcat/{__version__}"},
        )
        start = time.perf_counter()
        try:
            with _opener_for(url).open(req, timeout=timeout) as resp:
                code = resp.status
                body = resp.read(_BODY_LIMIT)
        except urllib.error.HTTPError as e:
            code = e.code
            body = e.read(_BODY_LIMIT) if e.fp else b""
        except (urllib.error.URLError, OSError, ValueError) as e:
            return self.result(Status.CRIT, describe_error(e, timeout))
        ms = (time.perf_counter() - start) * 1000
        metrics = {"latency_ms": round(ms, 1), "http_status": float(code)}

        expected = self.opts["expect_status"]
        ok_code = code in expected if expected else 200 <= code < 400
        if not ok_code:
            want = "/".join(str(c) for c in expected) if expected else "2xx/3xx"
            return self.result(Status.CRIT, f"回應 HTTP {code}（預期 {want}）", metrics)
        needle = self.opts["contains"]
        if needle and needle not in body.decode("utf-8", "replace"):
            return self.result(Status.CRIT, f"HTTP {code}，但內容裡沒有「{needle}」", metrics)
        warn_ms = self.opts["warn_ms"]
        if warn_ms is not None and ms >= warn_ms:
            return self.result(Status.WARN, f"HTTP {code}，但很慢：{ms:.0f} ms", metrics)
        return self.result(Status.OK, f"HTTP {code}，{ms:.0f} ms", metrics)


class TcpCheck(Check):
    kind = "tcp"
    label = "連接埠"
    primary = "latency_ms"
    default_confirm = 2
    options = {
        "host": Opt("str", "127.0.0.1"),
        "port": Opt("int"),
        "timeout": Opt("num", 5),
    }

    def default_name(self) -> str:
        return f"{self.opts['host']}:{self.opts['port']}"

    def ident(self) -> str:
        return f"{self.opts['host']}:{self.opts['port']}"

    def run(self, ctx: Context) -> CheckResult:
        host, port, timeout = self.opts["host"], self.opts["port"], self.opts["timeout"]
        start = time.perf_counter()
        try:
            with socket.create_connection((host, port), timeout=timeout):
                pass
        except OSError as e:
            return self.result(Status.CRIT, describe_error(e, timeout))
        ms = (time.perf_counter() - start) * 1000
        return self.result(
            Status.OK, f"{host}:{port} 連得上（{ms:.0f} ms）", {"latency_ms": round(ms, 1)}
        )
