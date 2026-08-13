"""Tests for :mod:`chronolock.cli` — argument parsing, error mapping, wiring.

The CLI's command handlers are intentionally thin (they delegate to the
library). These tests focus on the parts the CLI owns:

    - ``build_parser``: subcommands, flags, required args
    - ``_handle_errors``: exception → exit code / message mapping
    - ``main``: dispatch is wired to the right handler (with the library
      layers mocked out so we need no puzzle solving or real disk).
"""

from __future__ import annotations

import sys
from types import SimpleNamespace
from typing import List

import pytest

from chronolock import cli
from chronolock.errors import (
    ChronolockError,
    ConfigError,
    CorruptVaultError,
    IntegrityError,
    PuzzleError,
    VaultNotFoundError,
)


class TestBuildParser:
    """Structure of the top-level argument parser."""

    def test_requires_subcommand(self) -> None:
        """Invoking with no subcommand exits with a usage error."""
        with pytest.raises(SystemExit) as exc:
            cli.build_parser().parse_args([])
        assert exc.value.code == 2

    def test_subcommands_present(self) -> None:
        """All expected subcommands are registered."""
        parser = cli.build_parser()
        names = parser._subparsers._group_actions[0].choices.keys()
        assert {"bury", "open", "status", "list"} <= set(names)

    def test_bury_requires_name_and_secret(self) -> None:
        """``bury`` needs positional name and secret."""
        with pytest.raises(SystemExit) as exc:
            cli.build_parser().parse_args(["bury"])
        assert exc.value.code == 2

    def test_bury_accepts_options(self) -> None:
        """``bury`` parses all documented flags without error."""
        args = cli.build_parser().parse_args(
            [
                "bury",
                "myvault",
                "the secret",
                "--unlock-after",
                "1234567890",
                "--dir",
                "/tmp/x",
            ]
        )
        assert args.command == "bury"
        assert args.name == "myvault"
        assert args.secret == "the secret"
        assert args.unlock_after == 1234567890
        assert args.dir == "/tmp/x"

    def test_open_parses(self) -> None:
        """``open`` accepts an id and a ``--reveal`` flag."""
        args = cli.build_parser().parse_args(["open", "abc", "--reveal"])
        assert args.command == "open"
        assert args.vault_id == "abc"
        assert args.reveal is True

    def test_version_flag(self, capsys) -> None:
        """``--version`` prints the version and exits 0."""
        with pytest.raises(SystemExit) as exc:
            cli.build_parser().parse_args(["--version"])
        assert exc.value.code == 0


class TestHandleErrors:
    """Mapping of exceptions to exit codes and messages."""

    def _run(self, exc: BaseException) -> int:
        return cli._handle_errors(exc)

    def test_config_error(self, capsys) -> None:
        code = self._run(ConfigError("bad config"))
        assert code == 1
        assert "config error" in capsys.readouterr().err.lower()

    def test_vault_not_found(self, capsys) -> None:
        code = self._run(VaultNotFoundError("no vault", vault_id="abc"))
        assert code == 1
        assert "vault not found" in capsys.readouterr().err.lower()

    def test_corrupt_vault(self, capsys) -> None:
        code = self._run(CorruptVaultError("bad file"))
        assert code == 1
        assert "corrupt" in capsys.readouterr().err.lower()

    def test_integrity(self, capsys) -> None:
        code = self._run(IntegrityError("tampered"))
        assert code == 1
        assert "integrity" in capsys.readouterr().err.lower()

    def test_puzzle(self, capsys) -> None:
        code = self._run(PuzzleError("oops puzzle"))
        assert code == 1
        assert "puzzle" in capsys.readouterr().err.lower()

    def test_generic_chronolock(self, capsys) -> None:
        code = self._run(ChronolockError("generic"))
        assert code == 1
        assert "error" in capsys.readouterr().err.lower()

    def test_unexpected_exception(self, capsys) -> None:
        code = self._run(RuntimeError("boom"))
        assert code == 1
        err = capsys.readouterr().err.lower()
        assert "unexpected" in err or "boom" in err


class TestMainDispatch:
    """``main`` routes arguments to the right command handlers."""

    def test_bury_dispatches(self, monkeypatch) -> None:
        """``main([...])`` calls ``cmd_bury`` and returns its code."""
        calls: List[str] = []

        def fake_cmd_bury(args: SimpleNamespace) -> int:
            calls.append("bury")
            return 0

        monkeypatch.setattr(cli, "cmd_bury", fake_cmd_bury)
        monkeypatch.setattr(cli, "ui", type("U", (), {"enable_colour": lambda s: None})())
        code = cli.main(["bury", "n", "s"])
        assert code == 0
        assert calls == ["bury"]

    def test_unknown_command_exits_2(self) -> None:
        """An unknown subcommand is a usage error (exit 2)."""
        with pytest.raises(SystemExit) as exc:
            cli.main(["frobnicate"])
        assert exc.value.code == 2


def test_smoke_importable() -> None:
    """The CLI module imports cleanly and exposes ``main``."""
    assert callable(cli.main)


def test_build_store_defaults(monkeypatch, tmp_path) -> None:
    """``_build_store`` falls back to the default store path when ``--dir`` unset."""
    monkeypatch.setattr(cli.store, "default_store_path", lambda: str(tmp_path / "def"))
    args = SimpleNamespace(dir=None)
    s = cli._build_store(args)
    assert s.path == str((tmp_path / "def").resolve())