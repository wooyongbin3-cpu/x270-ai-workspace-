"""Vault operations: bury, open, status.

This is the orchestration layer of the library. It composes the three lower
layers:

    - :mod:`chronolock.puzzle`   — generate & solve the time-lock puzzle
    - :mod:`chronolock.crypto`   — encrypt/decrypt the secret
    - :mod:`chronolock.store`    — persist/load vault files on disk

Public functions:
    - :func:`bury`        — create a new time-locked vault
    - :func:`open_vault`  — solve the puzzle and reveal the secret
    - :func:`inspect`     — read public metadata without unlocking
    - :func:`vault_status`/ :func:`list_vaults` — convenience wrappers

Keep this layer free of UI concerns: no prints, no progress bars. All
progress reporting is done via callbacks so the CLI can render whatever it
likes (see :mod:`chronolock.ui`).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, List, Optional

from .errors import PuzzleError, VaultExistsError
from .model import UnlockResult, Vault, VaultMetadata, VaultStatus
from .puzzle import PuzzleSpec
from .store import VaultStore


@dataclass(frozen=True)
class BuryOptions:
    """User-controllable options for :func:`bury`.

    Attributes:
        name: Human-friendly label for the vault (displayed in listings).
            Must be non-empty and unique within the store.
        unlock_after: Unix timestamp (seconds) before which the vault should
            not be openable. Used (with the machine's hash rate) to calibrate
            puzzle difficulty. If ``None`` plus ``difficulty`` is provided,
            the difficulty is used directly.
        difficulty: Explicit puzzle difficulty (number of hash iterations).
            Overrides ``unlock_after`` calibration when both are given. Must
            satisfy :func:`chronolock.puzzle.validate_difficulty`.
        secret: The plaintext secret to bury. Must be non-empty and no larger
            than :data:`chronolock.crypto.MAX_SECRET_BYTES` bytes.
        meta: Arbitrary application metadata to attach to the vault. Stored
            in plaintext in the vault header — never put secrets here.
            Serialized as JSON; must be JSON-serializable.
    """

    name: str
    unlock_after: Optional[int] = None
    difficulty: Optional[int] = None
    secret: str = ""
    meta: Optional[dict] = None


#: Signature for progress callbacks: ``(vault, stage, done, total)``.
#: ``stage`` is one of ``"calibrating"``, ``"solving"``, ``"sealing"``.
ProgressCallback = Callable[[VaultMetadata, str, int, int], None]


def bury(store: VaultStore, options: BuryOptions, progress: Optional[ProgressCallback] = None) -> Vault:
    """Create a new time-locked vault and persist it to the store.

    This performs, in order:

    1. Validate options (name, secret, difficulty).
    2. Calibrate difficulty (from ``unlock_after`` + calibrated hash rate, or
       use an explicit ``difficulty``).
    3. Generate a random puzzle seed.
    4. Solve the puzzle once (yielding the final hash → the key material).
    5. Encrypt the secret under the puzzle-derived key.
    6. Serialize the vault file and write it to the store atomically.

    Args:
        store: The vault store to persist into.
        options: The user's choices (name, secret, timing, difficulty).
        progress: Optional callback invoked as the pipeline advances. The
            callback receives ``(metadata, stage, done, total)``.

    Returns:
        The newly created :class:`Vault` (including the plaintext secret, so
        the caller can confirm it matches what was buried).

    Raises:
        VaultExistsError: If a vault with the same name already exists.
        InvalidSecretError: If the secret is empty or too large.
        PuzzleError: If difficulty calibration or generation fails.
    """
    # TODO(TICKET-005): implement — orchestrate steps 1–6.
    #   Suggested decomposition:
    #     _validate_options(options)          -> None        (raises early)
    #     _calibrate_difficulty(options)      -> int
    #     spec = PuzzleSpec(seed=generate_seed(), difficulty=difficulty)
    #     solution = puzzle.solve(spec, progress=...)
    #     encrypted = crypto.encrypt(options.secret, solution.final_hash)
    #     metadata = VaultMetadata(...)
    #     store.save(metadata, encrypted)
    #   NOTE: never store the plaintext secret; return it only in memory.
    raise NotImplementedError


def open_vault(
    store: VaultStore,
    vault_id: str,
    progress: Optional[Callable[[int, int], None]] = None,
) -> UnlockResult:
    """Open a vault by solving its puzzle and decrypting its secret.

    This is the expensive operation: the entire puzzle must be re-solved from
    the seed recorded in the vault's header. There is no shortcut.

    Args:
        store: The vault store to load from.
        vault_id: The identifier of the vault to open.
        progress: Optional ``(done, total)`` callback forwarded to the puzzle
            solver (as a fraction of hash iterations).

    Returns:
        An :class:`UnlockResult` with the decrypted secret and solve stats.

    Raises:
        VaultNotFoundError: If no vault with that id exists.
        CorruptVaultError: If the vault file is malformed.
        IntegrityError: If the ciphertext fails its HMAC check.
        PuzzleError: If the puzzle fails to validate or solve.
    """
    # TODO(TICKET-005): implement —
    #   1. loaded = store.load(vault_id)  -> (metadata, encrypted)
    #   2. spec = PuzzleSpec(seed=loaded.seed, difficulty=loaded.metadata.difficulty)
    #   3. solution = puzzle.solve(spec, progress=progress)   [this is the delay]
    #   4. plaintext = crypto.decrypt(encrypted, solution.final_hash)
    #   5. return UnlockResult(Vault(metadata, secret=plaintext), iterations, elapsed)
    raise NotImplementedError


def inspect(store: VaultStore, vault_id: str) -> VaultMetadata:
    """Read a vault's public metadata without solving any puzzle.

    Cheap, safe, and suitable for listings and previews. Never reveals the
    secret.

    Args:
        store: The vault store.
        vault_id: The identifier of the vault to inspect.

    Returns:
        The vault's :class:`VaultMetadata`.

    Raises:
        VaultNotFoundError: If no vault with that id exists.
        CorruptVaultError: If the vault file is malformed.
    """
    # TODO(TICKET-005): implement — delegate to store.load_metadata(vault_id).
    raise NotImplementedError


def list_vaults(store: VaultStore) -> List[VaultMetadata]:
    """List all vaults' public metadata, newest first.

    Args:
        store: The vault store.

    Returns:
        A list of :class:`VaultMetadata`, sorted by ``created_at`` descending.
    """
    # TODO(TICKET-005): implement — enumerate the store and inspect each.
    raise NotImplementedError


def vault_status(metadata: VaultMetadata, now: Optional[int] = None) -> VaultStatus:
    """Derive a vault's effective status from its metadata and the clock.

    A vault whose ``unlock_after`` is in the past can be *attempted*; this is
    purely informational — the real enforcement is the puzzle itself.

    Args:
        metadata: The vault's metadata.
        now: Optional current Unix time. Defaults to ``time.time()``.

    Returns:
        The vault's :class:`VaultStatus`.
    """
    # TODO(TICKET-005): implement — compare unlock_after with now.
    raise NotImplementedError