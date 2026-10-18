"""Tests for :mod:`chronolock.difficulty` — calibration & duration formatting.

These tests use injected, deterministic hash rates so they never depend on
this machine's actual performance. They assert:

    - ``seconds_to_difficulty`` math and clamping
    - ``format_estimate`` human-readable output
    - ``measure_hash_rate`` sanity (positive, cached)
"""

from __future__ import annotations

import pytest

from chronolock import difficulty, puzzle


class TestSecondsToDifficulty:
    """Tests for :func:`difficulty.seconds_to_difficulty`."""

    def test_direct_math(self) -> None:
        """At a given hash rate, difficulty ≈ seconds * rate."""
        d = difficulty.seconds_to_difficulty(desired_seconds=10.0, hash_rate=500.0)
        assert d == pytest.approx(5000, abs=1)  # 10 * 500

    def test_identity_snap(self) -> None:
        """With an identity snap, result is the raw (rounded) maths."""
        d = difficulty.seconds_to_difficulty(desired_seconds=3.3, hash_rate=100.0)
        assert d == 330

    def test_custom_snap_applied(self) -> None:
        """A custom snap function is applied to the raw difficulty."""
        snap = lambda n: n - (n % 100)  # round down to hundreds  # noqa: E731
        d = difficulty.seconds_to_difficulty(desired_seconds=10.0, hash_rate=500.0, snap=snap)
        assert d == 5000  # 5000 already lands on a hundred

    def test_clamps_to_min(self) -> None:
        """Tiny desired times still produce at least MIN_DIFFICULTY."""
        d = difficulty.seconds_to_difficulty(desired_seconds=0.000001, hash_rate=1.0)
        assert d == puzzle.MIN_DIFFICULTY

    def test_clamps_to_max(self) -> None:
        """Absurd desired times are clamped to MAX_DIFFICULTY."""
        d = difficulty.seconds_to_difficulty(desired_seconds=1e18, hash_rate=1e9)
        assert d == puzzle.MAX_DIFFICULTY

    def test_returns_integer(self) -> None:
        """Result is always an int."""
        d = difficulty.seconds_to_difficulty(desired_seconds=0.75, hash_rate=10.0)
        assert isinstance(d, int)

    @pytest.mark.parametrize("bad", [0.0, -1.0, -100.0])
    def test_non_positive_time_raises(self, bad: float) -> None:
        """Non-positive desired times raise ValueError."""
        with pytest.raises(ValueError):
            difficulty.seconds_to_difficulty(desired_seconds=bad, hash_rate=100.0)

    def test_defaults_to_measured_rate(self, monkeypatch) -> None:
        """If no hash_rate given, uses the measured machine rate."""
        monkeypatch.setattr(difficulty, "measure_hash_rate", lambda samples: 1000.0)
        d = difficulty.seconds_to_difficulty(desired_seconds=2.0, hash_rate=None)
        assert d == 2000


class TestMeasureHashRate:
    """Tests for :func:`difficulty.measure_hash_rate`."""

    def test_returns_positive(self) -> None:
        """Measured rate is a positive float."""
        rate = difficulty.measure_hash_rate(samples=1000)
        assert isinstance(rate, float)
        assert rate > 0

    def test_cached_between_calls(self, monkeypatch) -> None:
        """Subsequent calls reuse the cached value (no re-benchmark)."""
        calls = {"n": 0}

        def fake_rate(samples: int) -> float:
            calls["n"] += 1
            return 42.0

        monkeypatch.setattr(difficulty, "_benchmark", fake_rate)
        # Reset any cached value.
        monkeypatch.setattr(difficulty, "_CACHED_RATE", None)
        first = difficulty.measure_hash_rate(1000)
        second = difficulty.measure_hash_rate(1000)
        assert first == second == 42.0
        assert calls["n"] == 1

    def test_invalid_samples_raise(self) -> None:
        """Non-positive sample counts raise ValueError."""
        with pytest.raises(ValueError):
            difficulty.measure_hash_rate(0)


class TestFormatEstimate:
    """Tests for :func:`difficulty.format_estimate`."""

    @pytest.mark.parametrize(
        ("seconds", "expected"),
        [
            (0, "0 seconds"),
            (1, "1 second"),
            (25, "25 seconds"),
            (60, "1 minute"),
            (90, "1 minute, 30 seconds"),
            (3661, "1 hour, 1 minute"),
            (3600 * 24, "1 day"),
            (3600 * 48, "2 days"),
            (3600 * 24 * 30, "30 days"),
            (3600 * 24 * 30 * 365, "12 months"),
        ],
    )
    def test_common_durations(self, seconds: int, expected: str) -> None:
        """Common durations format as expected (singular/plural handled)."""
        assert difficulty.format_estimate(seconds) == expected

    def test_fractional_seconds(self) -> None:
        """Sub-second values round sensibly."""
        assert difficulty.format_estimate(0.5) == "1 second"