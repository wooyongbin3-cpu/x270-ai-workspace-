"""Terminal rendering helpers for the Chronolock CLI.

This is the only module that knows about ANSI escapes, progress bars, and
pretty formatting. Everything else in the library stays dumb (returns data,
never prints). Centralising display here keeps the logic layers pure and
makes the CLI easy to test (the render functions are pure-ish: they return
strings given data, so they can be unit tested without a terminal).

Policy:
    - Never write secrets to stderr/stdout unless explicitly requested by an
      ``--reveal`` flag (and then only to stdout).
    - All rendering is best-effort; if the terminal is not a TTY, degrade
      gracefully to plain text.
"""

from __future__ import annotations

from datetime import datetime
from typing import List, Optional, TextIO

from .model import VaultMetadata


# ANSI colour codes (kept minimal; full styling is out of scope).
class _Colour:
    RESET = "\033[0m"
    DIM = "\033[2m"
    BOLD = "\033[1m"
    RED = "\033[31m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    BLUE = "\033[34m"
    MAGENTA = "\033[35m"
    CYAN = "\033[36m"


#: Whether colour output is enabled. Auto-detected from the stream + env.
_COLOUR_ENABLED: bool = True


def enable_colour(stream: TextIO) -> None:
    """Enable/disable ANSI colour based on whether ``stream`` is a TTY.

    Also honours the ``NO_COLOR`` and ``FORCE_COLOR`` env conventions.

    Args:
        stream: The output stream to test (typically ``sys.stdout``).
    """
    # TODO(TICKET-007): implement — set _COLOUR_ENABLED appropriately.
    #   Rules:
    #     - FORCE_COLOR set (and truthy) -> True
    #     - NO_COLOR set -> False
    #     - otherwise -> bool(getattr(stream, "isatty", lambda: False)())
    raise NotImplementedError


def _c(code: str, text: str) -> str:
    """Wrap ``text`` in an ANSI colour if colour is enabled, else plain text."""
    if not _COLOUR_ENABLED:
        return text
    return f"{code}{text}{_Colour.RESET}"


def _banner(text: str, width: int = 60) -> str:
    """Return a centred banner line wrapped in a box."""
    pad = max(1, (width - len(text) - 2) // 2)
    top_bot = "─" * (width - 2)
    return f"┌{top_bot}┐\n│{' ' * pad}{text}{' ' * (width - 2 - pad - len(text))}│\n└{top_bot}┘"


def _format_timestamp(ts: int) -> str:
    """Format a Unix timestamp as a local ISO string."""
    try:
        return datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M")
    except (OverflowError, OSError, ValueError):
        return f"<unparseable: {ts}>"


def _format_duration(seconds: float) -> str:
    """Format a duration in seconds as a compact human string."""
    # TODO(TICKET-007): implement — reuse chronolock.difficulty.format_estimate.
    raise NotImplementedError


def render_bury_summary(
    vault_id: str,
    name: str,
    unlock_after: int,
    difficulty: int,
    estimated_seconds: float,
) -> str:
    """Render the confirmation shown after ``chronolock bury``.

    Args:
        vault_id: The new vault's id.
        name: The vault's name.
        unlock_after: Unix timestamp when it may be opened.
        difficulty: The puzzle difficulty used.
        estimated_seconds: Estimated wall-clock solve time on *this* machine.

    Returns:
        A multi-line string (with ANSI colours) summarising the vault.
    """
    # TODO(TICKET-007): implement — compose the boxed summary via _banner
    #   and _format_timestamp/_format_duration.
    raise NotImplementedError


def render_progress_bar(
    done: int,
    total: int,
    *,
    width: int = 40,
    label: str = "",
) -> str:
    """Render a single-line progress bar.

    Args:
        done: Completed iterations.
        total: Total iterations.
        width: Character width of the bar fill area.
        label: Optional label shown after the bar.

    Returns:
        A string like ``"████▓░░░░░░ 32%"`` (or the plain ASCII fallback when
        colours are disabled).
    """
    # TODO(TICKET-007): implement —
    #   frac = clamp(done/total, 0..1); filled = round(frac*width)
    #   bar = "█"*filled + "░"*(width-filled)
    #   return f"{bar} {frac*100:.0f}%{label}"
    raise NotImplementedError


def render_header(metadata: VaultMetadata) -> str:
    """Render the human-readable single-vault header used by ``status``.

    Args:
        metadata: The vault's public metadata.

    Returns:
        A formatted multi-line string describing the vault (no secret).
    """
    # TODO(TICKET-007): implement — id, name, status, created, unlock,
    #   difficulty, estimated solve time.
    raise NotImplementedError


def render_list(metadatas: List[VaultMetadata], now: int) -> str:
    """Render a table of vaults for ``chronolock list``.

    Args:
        metadatas: The vaults' metadata, newest first.
        now: Current Unix time (for the "opens in" column).

    Returns:
        A formatted table string with aligned columns and colours.
    """
    # TODO(TICKET-007): implement — a name/status/opens-in table.
    raise NotImplementedError