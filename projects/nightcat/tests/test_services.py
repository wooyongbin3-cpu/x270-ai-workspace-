import subprocess
import sys
from collections.abc import Sequence

import pytest

from conftest import NOON, FakeTree
from nightcat.checks import Context
from nightcat.checks.services import CommandCheck, SystemdCheck
from nightcat.host import CommandResult, Host
from nightcat.model import Status


class ScriptedHost(Host):
    def __init__(self, reply: CommandResult | BaseException) -> None:
        super().__init__("/nonexistent", psutil=None)
        self.reply = reply
        self.calls: list[list[str]] = []

    def run(self, argv: Sequence[str], timeout: float) -> CommandResult:
        self.calls.append(list(argv))
        if isinstance(self.reply, BaseException):
            raise self.reply
        return self.reply


@pytest.mark.parametrize(
    ("stdout", "code", "status", "text"),
    [
        ("active\n", 0, Status.OK, "運行中"),
        ("activating\n", 3, Status.WARN, "啟動中"),
        ("failed\n", 3, Status.CRIT, "掛掉"),
        ("inactive\n", 3, Status.CRIT, "沒有在跑"),
        ("inactive\n", 4, Status.CRIT, "找不到這個服務"),
        ("weird\n", 3, Status.CRIT, "weird"),
    ],
)
def test_systemd_states(stdout: str, code: int, status: Status, text: str) -> None:
    host = ScriptedHost(CommandResult(code, stdout, ""))
    r = SystemdCheck(unit="meow-sync.service").run(Context(host, NOON))
    assert r.status is status and text in r.summary
    assert host.calls == [["systemctl", "is-active", "meow-sync.service"]]


def test_systemd_user_and_failures() -> None:
    host = ScriptedHost(CommandResult(0, "active", ""))
    SystemdCheck(unit="bot", user=True).run(Context(host, NOON))
    assert host.calls == [["systemctl", "--user", "is-active", "bot"]]
    r = SystemdCheck(unit="x").run(Context(ScriptedHost(FileNotFoundError()), NOON))
    assert r.status is Status.UNKNOWN and "沒有 systemctl" in r.summary
    r = SystemdCheck(unit="x").run(
        Context(ScriptedHost(CommandResult(1, "", "System has not been booted with systemd")), NOON)
    )
    assert r.status is Status.UNKNOWN and "not been booted" in r.summary


def _py(code: str) -> list[str]:
    return [sys.executable, "-c", code]


@pytest.mark.parametrize(
    ("exit_code", "status"),
    [(0, Status.OK), (1, Status.WARN), (2, Status.CRIT), (3, Status.UNKNOWN), (7, Status.CRIT)],
)
def test_command_nagios_codes(tree: FakeTree, exit_code: int, status: Status) -> None:
    r = CommandCheck(cmd=_py(f"print('磁碟陣列 OK'); raise SystemExit({exit_code})")).run(
        tree.ctx()
    )
    assert r.status is status and r.summary == "磁碟陣列 OK"
    assert r.metrics["exit_code"] == exit_code


def test_command_summary_fallbacks(tree: FakeTree) -> None:
    r = CommandCheck(cmd=_py("import sys; sys.stderr.write('oops\\n'); sys.exit(2)")).run(
        tree.ctx()
    )
    assert r.summary == "oops"
    r = CommandCheck(cmd=_py("raise SystemExit(0)")).run(tree.ctx())
    assert r.summary == "結束碼 0"


def test_command_errors(tree: FakeTree) -> None:
    r = CommandCheck(cmd=["definitely-not-a-real-command-xyz"]).run(tree.ctx())
    assert r.status is Status.UNKNOWN and "找不到指令" in r.summary
    r = CommandCheck(cmd=_py("import time; time.sleep(5)"), timeout=0.3).run(tree.ctx())
    assert r.status is Status.CRIT and "0.3 秒" in r.summary


def test_command_string_is_split() -> None:
    check = CommandCheck(cmd="pgrep -f 'bot.py --live'")
    assert check.opts["cmd"] == ["pgrep", "-f", "bot.py --live"]


def test_timeout_expired_is_reported(tree: FakeTree) -> None:
    host = ScriptedHost(subprocess.TimeoutExpired("systemctl", 15))
    r = SystemdCheck(unit="x").run(Context(host, NOON))
    assert r.status is Status.UNKNOWN
