"""Difficulty calibration: turn a human time goal into puzzle iterations.

The core idea of Chronolock is that the *delay* comes from work, not from a
clock. To make "this vault opens in about 30 days" meaningful, we must convert
a desired wall-clock duration into a number of sequential SHA-256 iterations
given this machine's measured hash rate.

Calibration flow (used by :func:`chronolock.vault.bury`):

    1. Measure the machine's SHA-256 hash rate with a short benchmark.
    2. ``iterations = desired_seconds * hash_rate``.
    3. Clamp into ``[MIN_DIFFICULTY, MAX_DIFFICULTY]``.
    4. Round / snap to a pleasant number for nicer UX.

Because hardware varies, the same difficulty yields wildly different wall-clock
times across machines. That is expected and honest: difficulty is a *compute*
budget, not a time promise. The CLI always shows its estimated wall-clock
result at bury time so the user can judge.

Notes:
    - ``hash_rate`` is measured with the same :mod:`hashlib` implementation
      the solver uses, so the estimate is representative.
    - We measure with a warm-up to avoid cold-cache skew.
"""

from __future__ import annotations

from typing import Callable, Optional

#: Number of hash iterations used in the benchmark sample.
BENCH_SAMPLE = 200_000

#: Fraction of the sample to iterate synchronously per progress tick.
PROGRESS_TICK = 0.02  # 2%

#: Signature for a hash-rate measuring function: ``(samples) -> rate``.
HashRateFn = Callable[[int], float]

#: Signature for a difficulty-snapping function: ``(difficulty) -> int``.
SnapFn = Callable[[int], int]


def measure_hash_rate(samples: int = BENCH_SAMPLE) -> float:
    """Measure this machine's SHA-256 hash rate (hashes/second).

    Runs a short warm-up then times ``samples`` sequential hashes. The result
    is cached after the first call (machines don't change hash rate within a
    process lifetime meaningfully).

    Args:
        samples: Number of hash iterations to time (larger = more accurate,
            slower to run). Must be positive.

    Returns:
        Measured hash rate as ``hashes/second`` (a ``float > 0``).

    Raises:
        ValueError: If ``samples`` is not positive.
    """
    # TODO(TICKET-006): implement —
    #   1. warm-up: e.g. 10k hashes
    #   2. time `samples` hashes (hashlib.sha256(bytes).digest() loop)
    #   3. return samples / elapsed_seconds
    #   4. cache result in a module-level variable
    raise NotImplementedError


def seconds_to_difficulty(
    desired_seconds: float,
    hash_rate: Optional[float] = None,
    snap: Optional[SnapFn] = None,
) -> int:
    """Convert a desired wall-clock duration into puzzle difficulty.

    ``difficulty = round(desired_seconds * hash_rate)``, clamped into the
    valid puzzle bounds and optionally snapped to a round number.

    Args:
        desired_seconds: Desired unlock duration in seconds, ``> 0``.
        hash_rate: Machine hash rate; defaults to
            :func:`measure_hash_rate`.
        snap: Optional function to prettify the difficulty (e.g. round to a
            power of 2). Defaults to identity (no snapping).

    Returns:
        A validated puzzle difficulty (``MIN_DIFFICULTY <= d <= MAX_DIFFICULTY``).

    Raises:
        ValueError: If ``desired_seconds`` is not positive.
    """
    # TODO(TICKET-006): implement —
    #   1. validate desired_seconds > 0
    #   2. rate = hash_rate or measure_hash_rate()
    #   3. d = round(desired_seconds * rate); clamp to bounds; snap
    #   4. return int(d)
    raise NotImplementedError


def format_estimate(seconds: float) -> str:
    """Format a duration (seconds) as a friendly human string.

    Examples:
        - 25  -> ``"25 seconds"``
        - 90  -> ``"1 minute, 30 seconds"``
        - 3661 -> ``"1 hour, 1 minute"``
        - 172800 -> ``"2 days"``

    Used by the CLI for bury/open estimates. Rounds coarsely; exactness is
    not a goal here.

    Args:
        seconds: Duration in seconds (may be fractional).

    Returns:
        A short human-readable duration string.
    """
    # TODO(TICKET-006): implement — decompose into d/h/m/s.
    raise NotImplementedError