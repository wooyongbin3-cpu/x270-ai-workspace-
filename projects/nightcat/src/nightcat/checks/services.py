"""服務：systemd unit 狀態，以及任意外部指令（相容 Nagios 外掛的結束碼）。"""

from __future__ import annotations

import subprocess

from ..model import CheckResult, Status
from .base import Check, Context, Opt

_SYSTEMD_STATES = {
    "active": (Status.OK, "運行中"),
    "reloading": (Status.WARN, "重新載入中"),
    "activating": (Status.WARN, "啟動中"),
    "deactivating": (Status.WARN, "正在停止"),
    "inactive": (Status.CRIT, "沒有在跑"),
    "failed": (Status.CRIT, "已經掛掉（failed）"),
}

_NAGIOS = {0: Status.OK, 1: Status.WARN, 2: Status.CRIT, 3: Status.UNKNOWN}


def first_line(text: str, limit: int = 200) -> str:
    for line in text.splitlines():
        line = line.strip()
        if line:
            return line if len(line) <= limit else line[: limit - 1] + "…"
    return ""


class SystemdCheck(Check):
    kind = "systemd"
    label = "服務"
    options = {
        "unit": Opt("str"),
        # 使用者層級的服務（systemctl --user）
        "user": Opt("bool", False),
    }

    def default_name(self) -> str:
        return str(self.opts["unit"])

    def ident(self) -> str:
        return str(self.opts["unit"])

    def run(self, ctx: Context) -> CheckResult:
        argv = ["systemctl"]
        if self.opts["user"]:
            argv.append("--user")
        argv += ["is-active", self.opts["unit"]]
        try:
            out = ctx.host.run(argv, timeout=15)
        except FileNotFoundError:
            return self.result(Status.UNKNOWN, "這台機器沒有 systemctl")
        except subprocess.TimeoutExpired:
            return self.result(Status.UNKNOWN, "systemctl 沒有回應")
        state = first_line(out.stdout)
        if not state:  # 例如容器裡沒有用 systemd 開機
            reason = first_line(out.stderr) or f"結束碼 {out.returncode}"
            return self.result(Status.UNKNOWN, f"systemctl 失敗：{reason}")
        status, text = _SYSTEMD_STATES.get(state, (Status.CRIT, f"狀態是 {state}"))
        if state == "inactive" and out.returncode == 4:  # 4 = 沒有這個 unit
            status, text = Status.CRIT, "找不到這個服務（名稱打錯？）"
        return self.result(status, text)


class CommandCheck(Check):
    """執行任意指令：結束碼 0 正常、1 注意、2 嚴重、3 未知，其他算嚴重。輸出第一行當摘要。"""

    kind = "command"
    label = "指令"
    options = {
        "cmd": Opt("cmd"),
        "timeout": Opt("num", 30),
    }

    def default_name(self) -> str:
        return " ".join(self.opts["cmd"])

    def ident(self) -> str:
        return " ".join(self.opts["cmd"])

    def run(self, ctx: Context) -> CheckResult:
        argv: list[str] = self.opts["cmd"]
        timeout: float = self.opts["timeout"]
        try:
            out = ctx.host.run(argv, timeout=timeout)
        except FileNotFoundError:
            return self.result(Status.UNKNOWN, f"找不到指令 {argv[0]}")
        except PermissionError:
            return self.result(Status.UNKNOWN, f"沒有權限執行 {argv[0]}")
        except subprocess.TimeoutExpired:
            return self.result(Status.CRIT, f"執行超過 {timeout:g} 秒還沒結束")
        status = _NAGIOS.get(out.returncode, Status.CRIT)
        summary = first_line(out.stdout) or first_line(out.stderr) or f"結束碼 {out.returncode}"
        return self.result(status, summary, {"exit_code": float(out.returncode)})
