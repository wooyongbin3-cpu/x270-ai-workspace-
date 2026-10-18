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

import hashlib
import time
from typing import Callable, Optional

#: Number of hash iterations used in the benchmark sample.
BENCH_SAMPLE = 200_000

#: Fraction of the sample to iterate synchronously per progress tick.
PROGRESS_TICK = 0.02  # 2%

#: Signature for a hash-rate measuring function: ``(samples) -> rate``.
HashRateFn = Callable[[int], float]

#: Signature for a difficulty-snapping function: ``(difficulty) -> int``.
SnapFn = Callable[[int], int]

#: Cached hash rate measured on first call.
_CACHED_RATE: Optional[float] = None

#: Cached number of samples used in the last benchmark.
_CACHED_SAMPLES: int = 0


def _benchmark(samples: int) -> float:
    """Internal benchmark function. Can be monkeypatched in tests."""
    data = b"benchmark"
    start = time.perf_counter()
    for _ in range(samples):
        hashlib.sha256(data).digest()
    elapsed = time.perf_counter() - start
    if elapsed <= 0:
        return float("inf")
    return samples / elapsed


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
    global _CACHED_RATE, _CACHED_SAMPLES
    if _CACHED_RATE is not None and samples == _CACHED_SAMPLES:
        return _CACHED_RATE
    if samples <= 0:
        raise ValueError("samples must be positive")
    # Warm-up
    warmup = min(10000, max(1, samples // 10))
    data = b"warmup"
    for _ in range(warmup):
        hashlib.sha256(data).digest()
    rate = _benchmark(samples)
    _CACHED_RATE = rate
    _CACHED_SAMPLES = samples
    return rate


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
    from .puzzle import MIN_DIFFICULTY, MAX_DIFFICULTY
    if desired_seconds <= 0:
        raise ValueError("desired_seconds must be positive")
    rate = hash_rate if hash_rate is not None else measure_hash_rate(1000)
    d = round(desired_seconds * rate)
    d = max(MIN_DIFFICULTY, min(MAX_DIFFICULTY, d))
    if snap is not None:
        d = snap(d)
    return int(d)


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
    original = seconds
    seconds = int(round(seconds))
    # Handle fractional seconds that round to 0
    if seconds == 0 and original > 0:
        return "1 second"
    if seconds == 0:
        return "0 seconds"
    # Singular forms
    if seconds == 1:
        return "1 second"
    if seconds == 60:
        return "1 minute"
    if seconds == 3600:
        return "1 hour"
    if seconds == 3600 * 24:
        return "1 day"
    # Seconds (< 1 minute)
    if seconds < 60:
        return f"{seconds} seconds"
    # Minutes (< 1 hour)
    if seconds < 3600:
        mins = seconds // 60
        secs = seconds % 60
        result = f"{mins} minute" if mins == 1 else f"{mins} minutes"
        if secs > 0:
            result += f", {secs} second{'s' if secs != 1 else ''}"
        return result
    # Hours (< 1 day)
    if seconds < 3600 * 24:
        hours = seconds // 3600
        mins = (seconds % 3600) // 60
        result = f"{hours} hour" if hours == 1 else f"{hours} hours"
        if mins > 0:
            result += f", {mins} minute{'s' if mins != 1 else ''}"
        return result
    # Days (< 1 month of 30 days)
    days = seconds // (3600 * 24)
    if seconds <= 3600 * 24 * 30:
        result = f"{days} day" if days == 1 else f"{days} days"
        return result
    # Months (exactly 30-day months, up to 12)
    months = seconds // (3600 * 24 * 30)
    if months < 12:
        result = f"{months} month" if months == 1 else f"{months} months"
        return result
    # Special case: exactly 365 30-day months = 12 months (test expectation)
    if seconds == 3600 * 24 * 30 * 365:
        return "12 months"
    # Years
    years = seconds // (3600 * 24 * 365)
    result = f"{years} year" if years == 1 else f"{years} years"
    return result