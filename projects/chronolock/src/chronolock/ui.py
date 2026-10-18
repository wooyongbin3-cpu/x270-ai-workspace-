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

import os
from datetime import datetime
from typing import TextIO

from .difficulty import format_estimate
from .model import VaultMetadata, VaultStatus


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
    global _COLOUR_ENABLED
    force = os.environ.get("FORCE_COLOR", "")
    if force and force != "0":
        _COLOUR_ENABLED = True
    elif "NO_COLOR" in os.environ:
        _COLOUR_ENABLED = False
    else:
        isatty = getattr(stream, "isatty", None)
        _COLOUR_ENABLED = bool(isatty()) if callable(isatty) else False


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


def _field(label: str, value: str) -> str:
    """Render one aligned ``label: value`` line."""
    return f"  {_c(_Colour.DIM, f'{label:<11}')}{value}"


def _status_label(status: VaultStatus) -> str:
    """Colourise a vault status."""
    colour = _Colour.GREEN if status is VaultStatus.UNLOCKED else _Colour.YELLOW
    return _c(colour, status.value)


def _format_duration(seconds: float) -> str:
    """Format a duration in seconds as a compact human string."""
    return format_estimate(seconds)


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
    lines = [
        _c(_Colour.BOLD, _banner("vault buried")),
        _field("id", _c(_Colour.CYAN, vault_id)),
        _field("name", name),
        _field("unlocks", _format_timestamp(unlock_after)),
        _field("difficulty", f"{difficulty:,} iterations"),
        _field("est. solve", f"~{_format_duration(estimated_seconds)} on this machine"),
    ]
    return "\n".join(lines)


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
    frac = min(1.0, max(0.0, done / total)) if total > 0 else 1.0
    filled = round(frac * width)
    bar = "█" * filled + "░" * (width - filled)
    suffix = f" {label}" if label else ""
    return f"{_c(_Colour.GREEN, bar)} {frac * 100:3.0f}%{suffix}"


def render_header(metadata: VaultMetadata) -> str:
    """Render the human-readable single-vault header used by ``status``.

    Args:
        metadata: The vault's public metadata.

    Returns:
        A formatted multi-line string describing the vault (no secret).
    """
    lines = [
        _c(_Colour.BOLD, metadata.name),
        _field("id", _c(_Colour.CYAN, metadata.vault_id)),
        _field("status", _status_label(metadata.status)),
        _field("created", _format_timestamp(metadata.created_at)),
        _field("unlocks", _format_timestamp(metadata.unlock_after)),
        _field("difficulty", f"{metadata.difficulty:,} iterations"),
        _field("format", metadata.solver_version),
    ]
    return "\n".join(lines)


def render_list(metadatas: list[VaultMetadata], now: int) -> str:
    """Render a table of vaults for ``chronolock list``.

    Args:
        metadatas: The vaults' metadata, newest first.
        now: Current Unix time (for the "opens in" column).

    Returns:
        A formatted table string with aligned columns and colours.
    """
    if not metadatas:
        return _c(_Colour.DIM, "no vaults yet — create one with `chronolock bury`")
    rows = []
    for md in metadatas:
        remaining = md.unlock_after - now
        opens = "now" if remaining <= 0 else f"in {_format_duration(remaining)}"
        status = "ready" if remaining <= 0 else md.status.value
        rows.append((md.name, md.vault_id[:8], status, opens))
    headers = ("NAME", "ID", "STATUS", "OPENS")
    widths = [max(len(h), *(len(r[i]) for r in rows)) for i, h in enumerate(headers)]

    def fmt(cells: tuple[str, ...], status_colour: str = "") -> str:
        padded = [c.ljust(w) for c, w in zip(cells, widths, strict=True)]
        if status_colour:
            padded[2] = _c(status_colour, padded[2])
        return "  ".join(padded).rstrip()

    out = [_c(_Colour.BOLD, fmt(headers))]
    for row in rows:
        out.append(fmt(row, _Colour.GREEN if row[2] == "ready" else _Colour.YELLOW))
    return "\n".join(out)
