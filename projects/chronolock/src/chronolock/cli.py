"""Command-line interface for Chronolock.

This module wires the library composition root together: argument parsing,
error handling, progress reporting, and rendering.

Command surface:
    chronolock bury   <name> <secret> [--unlock-after X] [--difficulty N] [--dir DIR]
    chronolock open   <id>  [--reveal] [--dir DIR]
    chronolock status <id>  [--dir DIR]
    chronolock list         [--dir DIR] [--verbose]
    chronolock version
    chronolock help

Exit codes:
    0 success
    1 any operational error (vault missing, corrupt, etc.)
    2 usage/argument error (argparse)

Error handling is centralised in :func:`main` via :func:`_handle_errors`:
the library raises typed exceptions (:mod:`chronolock.errors`), the CLI maps
them to friendly stderr messages and a consistent non-zero exit code.
"""

from __future__ import annotations

import argparse
import sys
import time
from typing import List, Optional, Sequence

from . import __version__, difficulty, store, ui, vault
from .errors import ChronolockError, ConfigError


def build_parser() -> argparse.ArgumentParser:
    """Construct the top-level argument parser.

    Returns:
        The configured ``argparse.ArgumentParser`` for the CLI.
    """
    parser = argparse.ArgumentParser(
        prog="chronolock",
        description="Bury a secret behind a cryptographic time-lock. "
        "It opens only after enough sequential compute has been done.",
    )
    parser.add_argument(
        "--version",
        action="version",
        version=f"chronolock {__version__}",
    )
    parser.add_argument(
        "--dir",
        default=None,
        metavar="DIR",
        help="Vault store directory (default: OS data dir or $CHRONOLOCK_DIR).",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    # bury
    p_bury = sub.add_parser("bury", help="Create a new time-locked vault.")
    p_bury.add_argument("name", help="A short label for the vault.")
    p_bury.add_argument("secret", help="The secret text to seal (use quotes).")
    p_bury.add_argument(
        "--unlock-after",
        type=int,
        metavar="UNIXTS",
        help="Unix timestamp before which it should not open "
        "(calibrates difficulty).",
    )
    p_bury.add_argument(
        "--duration",
        type=int,
        metavar="SECONDS",
        help="Calibrate difficulty so opening takes about this long "
        "on this machine (alternative to --unlock-after).",
    )
    p_bury.add_argument(
        "--difficulty",
        type=int,
        metavar="N",
        help="Explicit puzzle difficulty (hash iterations). Overrides "
        "calibration.",
    )
    p_bury.set_defaults(func=cmd_bury)

    # open
    p_open = sub.add_parser("open", help="Solve a vault's puzzle and reveal it.")
    p_open.add_argument("vault_id", help="The vault id to open.")
    p_open.add_argument(
        "--reveal",
        action="store_true",
        help="Print the decrypted secret to stdout.",
    )
    p_open.set_defaults(func=cmd_open)

    # status
    p_status = sub.add_parser("status", help="Show a vault's public metadata.")
    p_status.add_argument("vault_id", help="The vault id to inspect.")
    p_status.set_defaults(func=cmd_status)

    # list
    p_list = sub.add_parser("list", help="List all vaults.")
    p_list.add_argument(
        "--verbose",
        action="store_true",
        help="Also surface vaults whose headers failed to parse.",
    )
    p_list.set_defaults(func=cmd_list)

    return parser


def _build_store(args: argparse.Namespace) -> store.VaultStore:
    """Construct the vault store from CLI args, defaulting sensibly.

    Args:
        args: Parsed CLI arguments (must have ``dir``).

    Returns:
        An initialised :class:`store.VaultStore`.
    """
    directory = args.dir or store.default_store_path()
    return store.VaultStore(directory)


def cmd_bury(args: argparse.Namespace) -> int:
    """Run ``chronolock bury``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    # TODO(TICKET-008): implement —
    #   1. build BuryOptions from args (name, secret, unlock_after/difficulty)
    #   2. if both --unlock-after and --duration: ConfigError (conflicting)
    #   3. s = _build_store(args)
    #   4. result = vault.bury(s, options, progress=...)
    #      progress callback renders a live progress bar via ui.render_progress_bar
    #   5. print ui.render_bury_summary(...)
    #   6. return 0
    raise NotImplementedError


def cmd_open(args: argparse.Namespace) -> int:
    """Run ``chronolock open``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    # TODO(TICKET-008): implement —
    #   1. s = _build_store(args)
    #   2. result = vault.open_vault(s, args.vault_id, progress=...)
    #   3. print header; if args.reveal: print the secret to stdout
    #   4. print stats (iterations, elapsed, rate)
    #   5. return 0
    raise NotImplementedError


def cmd_status(args: argparse.Namespace) -> int:
    """Run ``chronolock status``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    # TODO(TICKET-008): implement —
    #   s = _build_store(args); md = vault.inspect(s, args.vault_id)
    #   print(ui.render_header(md)); return 0
    raise NotImplementedError


def cmd_list(args: argparse.Namespace) -> int:
    """Run ``chronolock list``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    # TODO(TICKET-008): implement —
    #   s = _build_store(args); mds = vault.list_vaults(s)
    #   print(ui.render_list(mds, now=int(time.time()))); return 0
    raise NotImplementedError


def _handle_errors(exc: BaseException) -> int:
    """Map a raised exception to a friendly stderr message and exit code.

    Args:
        exc: The exception raised during a command.

    Returns:
        The exit code corresponding to the failure (``1`` generally).
    """
    # TODO(TICKET-008): implement —
    #   if isinstance(exc, ConfigError)     -> "config error: {msg}"       -> exit 1
    #   if isinstance(exc, VaultNotFoundError)-> "vault not found: {msg}"   -> exit 1
    #   if isinstance(exc, CorruptVaultError)-> "corrupt vault: {msg}"     -> exit 1
    #   if isinstance(exc, IntegrityError)   -> "integrity check failed..." -> exit 1
    #   if isinstance(exc, PuzzleError)      -> "puzzle error: {msg}"       -> exit 1
    #   if isinstance(exc, ChronolockError)  -> "error: {msg}"              -> exit 1
    #   else                                  -> unexpected: print repr      -> exit 1
    #   Write to sys.stderr.
    raise NotImplementedError


def main(argv: Optional[Sequence[str]] = None) -> int:
    """CLI entry point.

    Args:
        argv: Command-line arguments (defaults to ``sys.argv[1:]``).

    Returns:
        Process exit code.
    """
    parser = build_parser()
    ui.enable_colour(sys.stdout)

    args = parser.parse_args(argv)
    try:
        return args.func(args)
    except ChronolockError as exc:
        code = _handle_errors(exc)
    except KeyboardInterrupt:
        print("interrupted", file=sys.stderr)
        return 130
    except Exception as exc:  # pragma: no cover - defensive catch-all
        code = _handle_errors(exc)
    return code


if __name__ == "__main__":  # pragma: no cover
    sys.exit(main())