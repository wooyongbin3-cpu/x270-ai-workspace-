"""Vault operations: bury, open, status."""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass
from typing import Callable, List, Optional

from .crypto import encrypt, decrypt
from .difficulty import measure_hash_rate, seconds_to_difficulty
from .errors import InvalidSecretError, PuzzleError
from .model import UnlockResult, Vault, VaultMetadata, VaultStatus
from .puzzle import PuzzleSpec, generate_seed, solve as puzzle_solve, validate_difficulty
from .store import VaultStore


@dataclass(frozen=True)
class BuryOptions:
    """User-controllable options for :func:`bury`."""

    name: str
    unlock_after: Optional[int] = None
    difficulty: Optional[int] = None
    secret: str = ""
    meta: Optional[dict] = None


ProgressCallback = Callable[[VaultMetadata, str, int, int], None]


def _validate_options(options: BuryOptions) -> None:
    """Validate bury options early."""
    from .crypto import MAX_SECRET_BYTES
    if not options.secret:
        raise InvalidSecretError("secret must not be empty")
    if len(options.secret.encode("utf-8")) > MAX_SECRET_BYTES:
        raise InvalidSecretError("secret exceeds maximum size")
    if options.difficulty is not None:
        validate_difficulty(options.difficulty)


def _calibrate_difficulty(options: BuryOptions, now: Optional[int] = None) -> int:
    """Determine the puzzle difficulty to use."""
    if options.difficulty is not None:
        return options.difficulty
    if options.unlock_after is None:
        from .puzzle import MIN_DIFFICULTY
        return MIN_DIFFICULTY
    current_time = now or int(time.time())
    desired_seconds = options.unlock_after - current_time
    if desired_seconds <= 0:
        from .puzzle import MIN_DIFFICULTY
        return MIN_DIFFICULTY
    rate = measure_hash_rate()
    return seconds_to_difficulty(desired_seconds, rate)


def bury(
    store: VaultStore,
    options: BuryOptions,
    progress: Optional[ProgressCallback] = None,
) -> Vault:
    """Create a new time-locked vault and persist it to the store."""
    _validate_options(options)
    difficulty = _calibrate_difficulty(options)
    seed = generate_seed()
    spec = PuzzleSpec(seed=seed, difficulty=difficulty)
    solution = puzzle_solve(spec)
    encrypted = encrypt(options.secret, solution.final_hash)

    now = int(time.time())
    metadata = VaultMetadata(
        vault_id=uuid.uuid4().hex,
        name=options.name,
        created_at=now,
        unlock_after=options.unlock_after or now + difficulty,
        difficulty=difficulty,
        ciphertext_len=len(encrypted.ciphertext),
        status=VaultStatus.LOCKED,
        solver_version="puzzle-v1",
    )
    store.save(metadata, encrypted, seed)
    return Vault(metadata=metadata, secret=options.secret)


def open_vault(
    store: VaultStore,
    vault_id: str,
    progress: Optional[Callable[[int, int], None]] = None,
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


def list_vaults(store: VaultStore) -> List[VaultMetadata]:
    """List all vaults' public metadata, newest first."""
    return store.list_metadata()


def vault_status(metadata: VaultMetadata, now: Optional[int] = None) -> VaultStatus:
    """Derive a vault's effective status from its metadata and the clock."""
    current = now or int(time.time())
    if current >= metadata.unlock_after:
        return VaultStatus.UNLOCKED
    return VaultStatus.LOCKED
