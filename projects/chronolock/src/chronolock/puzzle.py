"""The time-lock puzzle: a sequential hash chain (proof-of-work).

This is the mathematical heart of Chronolock. A vault's secret is encrypted
with a key derived from the *final* state of a long hash chain. Recovering
that key requires re-computing the chain from its start, one SHA-256 hash at
a time, in strict sequence. Because each step depends on the previous one,
the work cannot be parallelised: 10,000 GPUs are no faster than one CPU.

The puzzle is a concrete instantiation of the classic
Rivest–Shamir–Wagner *time-lock puzzle* idea, adapted to a pure
proof-of-work chain:

    Given a starting seed ``S`` and a difficulty ``d``, the chain is::

        h_0 = SHA256(S)
        h_1 = SHA256(h_0)
        ...
        h_d = SHA256(h_{d-1})

    The final value ``h_d`` is the *puzzle solution*. The key used to encrypt
    the vault is derived from ``h_d`` via HKDF (see :mod:`chronolock.crypto`).

To *create* a vault you only need ``h_0`` and ``d`` — you compute the whole
chain once to get ``h_d``. To *open* a vault you must re-derive ``h_d`` by
repeating the chain. The "delay" is purely a function of how many hashes you
must compute, which is exactly ``d``.

Design requirements (see SPEC.md §4):
    - Sequential: no shortcut, no parallelisation win.
    - Verifiable: the solver can check progress but not skip ahead.
    - Bounded: difficulty is a positive integer with sane limits.
    - Deterministic: the same seed + difficulty always yields the same result.
"""

from __future__ import annotations

import hashlib
import os
from dataclasses import dataclass
from typing import Callable, Optional

from chronolock.errors import PuzzleError

#: The canonical solver version string. Stored in every vault header so we
#: can refuse to open vaults produced by a solver we no longer understand.
SOLVER_VERSION = "puzzle-v1"

#: Allowed difficulty bounds (inclusive). Kept proportional to sanity: a
#: difficulty of 1 is a trivial puzzle; 2**32 is billions of hashes.
MIN_DIFFICULTY = 1
MAX_DIFFICULTY = 2**32

#: Callback signature used to report progress while solving.
#: ``done`` is the number of iterations completed, ``total`` the difficulty.
ProgressCallback = Callable[[int, int], None]


@dataclass(frozen=True)
class PuzzleSpec:
    """Everything needed to *evaluate* a puzzle (compute the final chain state).

    This is the public, non-secret portion of a puzzle. It is stored in the
    vault header so that anyone can later solve the puzzle.

    Attributes:
        seed: The starting seed bytes for the hash chain. Generated randomly
            at bury time; stored in the header (it is not secret — the work
            is what protects the vault, not the seed).
        difficulty: Number of sequential hash iterations, ``d``.
        version: The solver version string (``SOLVER_VERSION``).
    """

    seed: bytes
    difficulty: int
    version: str = SOLVER_VERSION


@dataclass(frozen=True)
class PuzzleSolution:
    """The result of evaluating a puzzle.

    Attributes:
        final_hash: The final chained hash ``h_d`` — this is the value from
            which the encryption key is derived.
        iterations: The number of hash iterations that were actually performed
            (should equal ``difficulty`` for a complete solve).
    """

    final_hash: bytes
    iterations: int


def generate_seed(entropy_source: Optional[Callable[[int], bytes]] = None) -> bytes:
    """Generate a fresh random seed for a new puzzle.

    Uses :func:`os.urandom` by default. The ``entropy_source`` parameter is
    provided for testability (inject a deterministic source in unit tests).

    Args:
        entropy_source: Optional callable ``(nbytes) -> bytes`` returning
            cryptographically secure random bytes. Defaults to ``os.urandom``.

    Returns:
        A 32-byte seed.
    """
    source = entropy_source or os.urandom
    return source(32)


def validate_difficulty(difficulty: int) -> None:
    """Validate that a difficulty value is within the allowed bounds.

    Raises:
        PuzzleError: If ``difficulty`` is not an integer within
            ``[MIN_DIFFICULTY, MAX_DIFFICULTY]``.
    """
    if not isinstance(difficulty, int) or isinstance(difficulty, bool):
        raise PuzzleError(f"difficulty must be an integer, got {type(difficulty).__name__}")
    if difficulty < MIN_DIFFICULTY or difficulty > MAX_DIFFICULTY:
        raise PuzzleError(f"difficulty {difficulty} out of range [{MIN_DIFFICULTY}, {MAX_DIFFICULTY}]")


def solve(spec: PuzzleSpec, progress: Optional[ProgressCallback] = None) -> PuzzleSolution:
    """Evaluate a puzzle by computing the full hash chain.

    Given a :class:`PuzzleSpec`, compute ``h_0 .. h_d`` in sequence and return
    the final chained hash. This is the operation whose cost is the "time" in
    time-lock. It is intentionally sequential and cannot be parallelised.

    The optional ``progress`` callback is invoked periodically (e.g. every
    1% of iterations) with ``(done, total)`` so the CLI can render a progress
    bar. It is never called from a background thread; solving is synchronous.

    Args:
        spec: The puzzle to solve.
        progress: Optional callback for progress reporting.

    Returns:
        The :class:`PuzzleSolution` with the final chained hash.

    Raises:
        PuzzleError: If the spec's difficulty is invalid or the version is
            unsupported.
    """
    if spec.version != SOLVER_VERSION:
        raise PuzzleError(f"unsupported solver version: {spec.version!r}")
    validate_difficulty(spec.difficulty)

    h = hashlib.sha256(spec.seed).digest()
    total = spec.difficulty
    step = max(1, total // 100)

    for i in range(1, total + 1):
        h = hashlib.sha256(h).digest()
        if progress is not None and i % step == 0:
            progress(i, total)

    return PuzzleSolution(final_hash=h, iterations=total)


def estimate_seconds(hash_rate: float, difficulty: int) -> float:
    """Estimate the wall-clock seconds to solve a puzzle at a given hash rate.

    Roughly ``difficulty / hash_rate``. Used by the ``bury`` command to show
    the user how long an unlock would take on their machine, and by the
    difficulty calibration layer (:mod:`chronolock.difficulty`).

    Args:
        hash_rate: Hash operations per second (``float > 0``).
        difficulty: The puzzle difficulty.

    Returns:
        Estimated seconds as a float.

    Raises:
        ValueError: If ``hash_rate`` is not positive.
    """
    if hash_rate <= 0:
        raise ValueError(f"hash_rate must be positive, got {hash_rate}")
    return difficulty / hash_rate