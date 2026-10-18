"""Vault operations: bury, open, status."""

from __future__ import annotations

import time
from collections.abc import Callable
from dataclasses import dataclass

from .crypto import MAX_SECRET_BYTES, decrypt, encrypt
from .difficulty import measure_hash_rate, seconds_to_difficulty
from .errors import InvalidSecretError
from .model import UnlockResult, Vault, VaultMetadata, VaultStatus
from .puzzle import MIN_DIFFICULTY, SOLVER_VERSION, PuzzleSpec, generate_seed, validate_difficulty
from .puzzle import solve as puzzle_solve
from .store import VaultStore, generate_vault_id


@dataclass(frozen=True)
class BuryOptions:
    """User-controllable options for :func:`bury`."""

    name: str
    unlock_after: int | None = None
    difficulty: int | None = None
    secret: str = ""
    meta: dict | None = None


#: ``progress(done, total)`` — forwarded to :func:`chronolock.puzzle.solve`.
ProgressCallback = Callable[[int, int], None]


def _validate_options(options: BuryOptions) -> None:
    """Validate bury options early."""
    if not options.name:
        raise InvalidSecretError("vault name must not be empty")
    if not options.secret:
        raise InvalidSecretError("secret must not be empty")
    if len(options.secret.encode("utf-8")) > MAX_SECRET_BYTES:
        raise InvalidSecretError("secret exceeds maximum size")
    if options.difficulty is not None:
        validate_difficulty(options.difficulty)


def _calibrate_difficulty(options: BuryOptions, now: int | None = None) -> int:
    """Determine the puzzle difficulty to use."""
    if options.difficulty is not None:
        return options.difficulty
    if options.unlock_after is None:
        return MIN_DIFFICULTY
    current_time = now if now is not None else int(time.time())
    desired_seconds = options.unlock_after - current_time
    if desired_seconds <= 0:
        return MIN_DIFFICULTY
    rate = measure_hash_rate()
    return seconds_to_difficulty(desired_seconds, rate)


def bury(
    store: VaultStore,
    options: BuryOptions,
    progress: ProgressCallback | None = None,
) -> Vault:
    """Create a new time-locked vault and persist it to the store.

    The creator performs the same sequential work as the opener: the puzzle's
    final hash *is* the key material, so it must be computed once here.
    """
    _validate_options(options)
    now = int(time.time())
    difficulty = _calibrate_difficulty(options, now)
    seed = generate_seed()
    solution = puzzle_solve(PuzzleSpec(seed=seed, difficulty=difficulty), progress=progress)
    encrypted = encrypt(options.secret, solution.final_hash)

    if options.unlock_after is not None:
        unlock_after = options.unlock_after
    else:
        unlock_after = now + max(1, round(difficulty / measure_hash_rate()))
    metadata = VaultMetadata(
        vault_id=generate_vault_id(),
        name=options.name,
        created_at=now,
        unlock_after=unlock_after,
        difficulty=difficulty,
        ciphertext_len=len(encrypted.ciphertext),
        status=VaultStatus.LOCKED,
        solver_version=SOLVER_VERSION,
    )
    store.save(metadata, encrypted, seed)
    return Vault(metadata=metadata, secret=options.secret)


def open_vault(
    store: VaultStore,
    vault_id: str,
    progress: ProgressCallback | None = None,
) -> UnlockResult:
    """Open a vault by solving its puzzle and decrypting its secret."""
    loaded = store.load(vault_id)
    spec = PuzzleSpec(seed=loaded.seed, difficulty=loaded.metadata.difficulty)
    start = time.monotonic()
    solution = puzzle_solve(spec, progress=progress)
    elapsed = time.monotonic() - start
    if elapsed == 0.0:
        elapsed = 1e-9
    plaintext = decrypt(loaded.encrypted, solution.final_hash)
    vault = Vault(metadata=loaded.metadata, secret=plaintext)
    return UnlockResult(vault=vault, iterations=solution.iterations, elapsed_seconds=elapsed)


def inspect(store: VaultStore, vault_id: str) -> VaultMetadata:
    """Read a vault's public metadata without solving any puzzle."""
    return store.load_metadata(vault_id)


def list_vaults(store: VaultStore) -> list[VaultMetadata]:
    """List all vaults' public metadata, newest first."""
    return store.list_metadata()


def vault_status(metadata: VaultMetadata, now: int | None = None) -> VaultStatus:
    """Derive a vault's effective status from its metadata and the clock."""
    current = now if now is not None else int(time.time())
    if current >= metadata.unlock_after:
        return VaultStatus.UNLOCKED
    return VaultStatus.LOCKED
