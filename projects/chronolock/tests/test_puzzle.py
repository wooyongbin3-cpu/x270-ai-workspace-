"""Tests for :mod:`chronolock.puzzle` — the hash-chain time-lock puzzle.

These tests exercise the core proof-of-work primitive in isolation.

Assertion strategy:
    - Deterministic: same input → same output (tested with a fixed seed).
    - Sequential: the output depends on every iteration; verify with
      difficulty=1 and difficulty=10.
    - Progress: the progress callback is invoked periodically.
    - Bounds: invalid difficulties are rejected.
    - Error: unsupported solver versions are rejected.
"""

from __future__ import annotations

from typing import List, Tuple

import pytest

from chronolock import puzzle
from chronolock.errors import PuzzleError


class TestGenerateSeed:
    """Tests for :func:`puzzle.generate_seed`."""

    def test_returns_32_bytes(self, entropy_source) -> None:
        """A generated seed is exactly 32 bytes."""
        seed = puzzle.generate_seed(entropy_source)
        assert isinstance(seed, bytes)
        assert len(seed) == 32

    def test_deterministic_with_source(self, entropy_source) -> None:
        """Repeated calls with the same source return the same seed."""
        assert puzzle.generate_seed(entropy_source) == puzzle.generate_seed(entropy_source)

    def test_default_source_is_urandom(self) -> None:
        """The default source (os.urandom) produces different seeds each call."""
        seeds = {puzzle.generate_seed() for _ in range(10)}
        assert len(seeds) == 10, "seeds must be collision-free"


class TestValidateDifficulty:
    """Tests for :func:`puzzle.validate_difficulty`."""

    @pytest.mark.parametrize("valid", [1, 2, 100, 2**31, 2**32])
    def test_valid_difficulties(self, valid: int) -> None:
        """Within-bounds difficulties are accepted."""
        puzzle.validate_difficulty(valid)  # should not raise

    @pytest.mark.parametrize("invalid", [0, -1, 2**32 + 1, 2**63])
    def test_invalid_difficulties(self, invalid: int) -> None:
        """Out-of-bounds difficulties raise PuzzleError."""
        with pytest.raises(PuzzleError):
            puzzle.validate_difficulty(invalid)

    def test_non_integer_raises(self) -> None:
        """Non-integer types are rejected."""
        with pytest.raises(PuzzleError):
            puzzle.validate_difficulty(1.5)  # type: ignore[arg-type]


class TestSolve:
    """Tests for :func:`puzzle.solve` — the sequential hash-chain solver."""

    def test_difficulty_1_returns_bytes(self, tiny_puzzle_spec) -> None:
        """A difficulty-1 puzzle returns a 32-byte hash."""
        # Override difficulty to 1 for this test
        spec = puzzle.PuzzleSpec(seed=tiny_puzzle_spec.seed, difficulty=1)
        result = puzzle.solve(spec)
        assert isinstance(result.final_hash, bytes)
        assert len(result.final_hash) == 32
        assert result.iterations == 1

    def test_deterministic(self, tiny_puzzle_spec) -> None:
        """Same spec yields identical solution."""
        r1 = puzzle.solve(tiny_puzzle_spec)
        r2 = puzzle.solve(tiny_puzzle_spec)
        assert r1.final_hash == r2.final_hash
        assert r1.iterations == r2.iterations

    def test_difficulty_affects_output(self, tiny_puzzle_spec) -> None:
        """Changing difficulty changes the final hash (avalanche)."""
        base = puzzle.solve(puzzle.PuzzleSpec(seed=tiny_puzzle_spec.seed, difficulty=1))
        higher = puzzle.solve(puzzle.PuzzleSpec(seed=tiny_puzzle_spec.seed, difficulty=3))
        assert base.final_hash != higher.final_hash

    def test_iterations_match_difficulty(self, tiny_puzzle_spec) -> None:
        """``iterations`` equals the spec's ``difficulty``."""
        result = puzzle.solve(tiny_puzzle_spec)
        assert result.iterations == tiny_puzzle_spec.difficulty

    def test_unsupported_version_raises(self) -> None:
        """An unknown ``version`` string raises PuzzleError."""
        spec = puzzle.PuzzleSpec(seed=b"\x00" * 32, difficulty=5, version="v0")
        with pytest.raises(PuzzleError):
            puzzle.solve(spec)

    def test_invalid_difficulty_raises(self) -> None:
        """With invalid difficulty the call raises PuzzleError."""
        spec = puzzle.PuzzleSpec(seed=b"\x00" * 32, difficulty=-1)
        with pytest.raises(PuzzleError):
            puzzle.solve(spec)


class TestSolveProgress:
    """Tests that the optional progress callback is called during solve."""

    def test_progress_calls_on_large(self) -> None:
        """A large puzzle invokes the callback at least once."""
        spec = puzzle.PuzzleSpec(seed=b"\x00" * 32, difficulty=1000)

        invoked: List[Tuple[int, int]] = []

        def progress(done: int, total: int) -> None:
            invoked.append((done, total))

        puzzle.solve(spec, progress=progress)
        assert len(invoked) > 0

    def test_progress_calls_are_monotonic(self) -> None:
        """Callback ``done`` values are non-decreasing."""
        spec = puzzle.PuzzleSpec(seed=b"\x00" * 32, difficulty=100)
        last_done = -1

        def progress(done: int, total: int) -> None:
            nonlocal last_done
            assert done >= last_done
            last_done = done

        puzzle.solve(spec, progress=progress)

    def test_final_progress_matches_total(self) -> None:
        """The final callback has ``done == total``."""
        spec = puzzle.PuzzleSpec(seed=b"\x00" * 32, difficulty=100)
        final: Tuple[int, int] = (0, 0)

        def progress(done: int, total: int) -> None:
            nonlocal final
            final = (done, total)

        puzzle.solve(spec, progress=progress)
        assert final[0] == final[1] == spec.difficulty


class TestEstimateSeconds:
    """Tests for :func:`puzzle.estimate_seconds`."""

    def test_basic_division(self) -> None:
        """At a known hash rate the estimate is straightforward."""
        secs = puzzle.estimate_seconds(hash_rate=500.0, difficulty=1000)
        assert secs == pytest.approx(2.0, rel=1e-9)

    def test_one_iteration(self) -> None:
        """Difficulty 1 at any positive rate is `1 / rate`."""
        secs = puzzle.estimate_seconds(hash_rate=200.0, difficulty=1)
        assert secs == pytest.approx(0.005, rel=1e-9)

    @pytest.mark.parametrize("rate", [0.0, -1.0])
    def test_non_positive_rate_raises(self, rate: float) -> None:
        """Non-positive hash rates raise ValueError."""
        with pytest.raises(ValueError):
            puzzle.estimate_seconds(hash_rate=rate, difficulty=10)

    def test_zero_difficulty(self) -> None:
        """Difficulty 0 should estimate 0 seconds for any positive rate."""
        secs = puzzle.estimate_seconds(hash_rate=100.0, difficulty=0)
        assert secs == 0.0