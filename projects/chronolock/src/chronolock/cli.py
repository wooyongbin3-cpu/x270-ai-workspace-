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
from collections.abc import Callable, Sequence

from . import __version__, difficulty, store, ui, vault
from .errors import (
    ChronolockError,
    ConfigError,
    CorruptVaultError,
    IntegrityError,
    PuzzleError,
    VaultNotFoundError,
)


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
    # Also accept ``--dir`` after the subcommand; SUPPRESS keeps a top-level
    # value from being overwritten by the subparser's default.
    common = argparse.ArgumentParser(add_help=False)
    common.add_argument("--dir", default=argparse.SUPPRESS, metavar="DIR", help=argparse.SUPPRESS)

    sub = parser.add_subparsers(dest="command", required=True)

    # bury
    p_bury = sub.add_parser("bury", parents=[common], help="Create a new time-locked vault.")
    p_bury.add_argument("name", help="A short label for the vault.")
    p_bury.add_argument("secret", help="The secret text to seal (use quotes).")
    p_bury.add_argument(
        "--unlock-after",
        type=int,
        metavar="UNIXTS",
        help="Unix timestamp before which it should not open (calibrates difficulty).",
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
        help="Explicit puzzle difficulty (hash iterations). Overrides calibration.",
    )
    p_bury.set_defaults(func=cmd_bury)

    # open
    p_open = sub.add_parser("open", parents=[common], help="Solve a vault's puzzle and reveal it.")
    p_open.add_argument("vault_id", help="The vault id to open.")
    p_open.add_argument(
        "--reveal",
        action="store_true",
        help="Print the decrypted secret to stdout.",
    )
    p_open.set_defaults(func=cmd_open)

    # status
    p_status = sub.add_parser("status", parents=[common], help="Show a vault's public metadata.")
    p_status.add_argument("vault_id", help="The vault id to inspect.")
    p_status.set_defaults(func=cmd_status)

    # list
    p_list = sub.add_parser("list", parents=[common], help="List all vaults.")
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


def _resolve_id(s: store.VaultStore, ref: str) -> str:
    """Expand a unique vault-id prefix (as shown by ``list``) to a full id."""
    ids = s.list_ids()
    if ref in ids:
        return ref
    matches = [vid for vid in ids if vid.startswith(ref)]
    if len(matches) == 1:
        return matches[0]
    if matches:
        raise ConfigError(f"ambiguous vault id prefix {ref!r} ({len(matches)} matches)")
    raise VaultNotFoundError(f"no vault matches {ref!r}", ref)


def _progress_printer(label: str) -> Callable[[int, int], None] | None:
    """Return a callback drawing a live progress bar on stderr (TTY only)."""
    if not sys.stderr.isatty():
        return None

    def report(done: int, total: int) -> None:
        end = "\n" if done >= total else ""
        print("\r" + ui.render_progress_bar(done, total, label=label), end=end, file=sys.stderr)

    return report


def cmd_bury(args: argparse.Namespace) -> int:
    """Run ``chronolock bury``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    given = [f for f in ("unlock_after", "duration", "difficulty") if getattr(args, f) is not None]
    if not given:
        raise ConfigError("one of --unlock-after, --duration or --difficulty is required")
    if args.unlock_after is not None and args.duration is not None:
        raise ConfigError("--unlock-after and --duration are mutually exclusive")
    if args.duration is not None and args.difficulty is not None:
        raise ConfigError("--duration and --difficulty are mutually exclusive")
    for flag in ("unlock_after", "duration"):
        value = getattr(args, flag)
        if value is not None and value <= 0:
            raise ConfigError(f"--{flag.replace('_', '-')} must be a positive integer")

    unlock_after = args.unlock_after
    if args.duration is not None:
        unlock_after = int(time.time()) + args.duration
    options = vault.BuryOptions(
        name=args.name,
        secret=args.secret,
        unlock_after=unlock_after,
        difficulty=args.difficulty,
    )
    s = _build_store(args)
    if any(md.name == args.name for md in vault.list_vaults(s)):
        raise ConfigError(f"a vault named {args.name!r} already exists")

    buried = vault.bury(s, options, progress=_progress_printer("sealing"))
    md = buried.metadata
    print(
        ui.render_bury_summary(
            md.vault_id,
            md.name,
            md.unlock_after,
            md.difficulty,
            md.difficulty / difficulty.measure_hash_rate(),
        )
    )
    return 0


def cmd_open(args: argparse.Namespace) -> int:
    """Run ``chronolock open``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    s = _build_store(args)
    result = vault.open_vault(
        s, _resolve_id(s, args.vault_id), progress=_progress_printer("solving")
    )
    print(ui.render_header(result.vault.metadata))
    print(
        f"  solved {result.iterations:,} iterations in "
        f"{result.elapsed_seconds:.2f}s ({result.rate:,.0f}/s)"
    )
    if args.reveal:
        print(result.vault.secret)
    else:
        print("  (secret hidden — re-run with --reveal to print it)", file=sys.stderr)
    return 0


def cmd_status(args: argparse.Namespace) -> int:
    """Run ``chronolock status``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    s = _build_store(args)
    print(ui.render_header(vault.inspect(s, _resolve_id(s, args.vault_id))))
    return 0


def cmd_list(args: argparse.Namespace) -> int:
    """Run ``chronolock list``.

    Args:
        args: Parsed arguments.

    Returns:
        Shell exit code (``0`` on success).
    """
    s = _build_store(args)
    print(ui.render_list(vault.list_vaults(s), now=int(time.time())))
    if args.verbose:
        good = {md.vault_id for md in vault.list_vaults(s)}
        for vid in s.list_ids():
            if vid not in good:
                print(f"warning: skipped unreadable vault {vid}", file=sys.stderr)
    return 0


def _handle_errors(exc: BaseException) -> int:
    """Map a raised exception to a friendly stderr message and exit code.

    Args:
        exc: The exception raised during a command.

    Returns:
        The exit code corresponding to the failure (``1`` generally).
    """
    prefixes = (
        (ConfigError, "config error"),
        (VaultNotFoundError, "vault not found"),
        (CorruptVaultError, "corrupt vault"),
        (IntegrityError, "integrity check failed"),
        (PuzzleError, "puzzle error"),
        (ChronolockError, "error"),
    )
    for exc_type, prefix in prefixes:
        if isinstance(exc, exc_type):
            print(f"{prefix}: {exc}", file=sys.stderr)
            return 1
    print(f"unexpected error: {exc!r}", file=sys.stderr)
    return 1


def main(argv: Sequence[str] | None = None) -> int:
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
        return int(args.func(args))
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
