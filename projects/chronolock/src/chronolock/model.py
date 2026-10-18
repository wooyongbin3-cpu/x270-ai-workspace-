"""Core data model for Chronolock vaults.

This module defines the in-memory representations of everything the tool
deals with:

    - :class:`VaultStatus`   — the lifecycle states a vault can be in
    - :class:`VaultMetadata` — the header information about a vault
    - :class:`Vault`         — a full vault, including its secret
    - :class:`UnlockResult`  — what you get back after a successful unlock

These dataclasses are the currency passed between the puzzle, crypto,
storage, and UI layers. Keep them free of I/O and pure data.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum


class VaultStatus(str, Enum):
    """The lifecycle states of a vault.

    - ``LOCKED``   — secret is sealed; puzzle must be solved to reveal it
    - ``SOLVING``  — an unlock has been started and the puzzle is in progress
    - ``UNLOCKED`` — the puzzle has been solved and the secret was decrypted
    """

    LOCKED = "locked"
    SOLVING = "solving"
    UNLOCKED = "unlocked"


@dataclass(frozen=True)
class VaultMetadata:
    """Public (non-secret) metadata describing a single vault.

    All fields are stored in the vault file's header in plaintext — that is
    intentional: knowing *that a vault exists* and *when it opens* is not the
    same as knowing its contents.

    Attributes:
        vault_id: A unique hex identifier for the vault.
        name: A human-friendly label the creator chose (like a subject line).
        created_at: Unix timestamp (seconds) when the vault was buried.
        unlock_after: Unix timestamp (seconds) before which the vault cannot
            be reasonably opened; the puzzle difficulty is calibrated to this.
        difficulty: The number of sequential hash operations in the puzzle.
        ciphertext_len: Length in bytes of the encrypted secret payload.
        status: Current lifecycle status of the vault.
        solver_version: The puzzle format version this vault was created with
            (currently ``"puzzle-v1"``).
    """

    vault_id: str
    name: str
    created_at: int
    unlock_after: int
    difficulty: int
    ciphertext_len: int
    status: VaultStatus = VaultStatus.LOCKED
    solver_version: str = "puzzle-v1"


@dataclass(frozen=True)
class Vault:
    """A complete vault: metadata plus its secret (in plaintext).

    This object exists transiently:

    - *After* :func:`chronolock.vault.bury` — the secret is in memory so the
      caller can display it / confirm it and optionally keep a copy.
    - *After* a successful unlock — the secret is decrypted into memory.

    A ``Vault`` is **never** serialized wholesale; only the encrypted payload
    lives on disk. Hanging onto a ``Vault`` object outside of a single command
    invocation means keeping a secret in memory — follow the guidance in
    :mod:`chronolock.crypto` about wiping memory where practical.

    Attributes:
        metadata: The vault's public metadata.
        secret: The plaintext secret. For a freshly buried vault this is what
            the user provided; for an unlocked vault this is the recovered
            plaintext. ``None`` while locked.
    """

    metadata: VaultMetadata
    secret: str | None = field(default=None)


@dataclass(frozen=True)
class UnlockResult:
    """The outcome of a successful unlock operation.

    Attributes:
        vault: The unlocked :class:`Vault`, including its plaintext secret.
        iterations: Number of puzzle hash iterations actually performed.
        elapsed_seconds: Wall-clock time spent solving the puzzle.
    """

    vault: Vault
    iterations: int
    elapsed_seconds: float

    @property
    def rate(self) -> float:
        """Solve rate in iterations per second (``iterations / elapsed``).

        Useful diagnostics and a nice stat to print in the CLI. Raises
        :class:`ZeroDivisionError` if elapsed time was zero (should not
        happen in practice for any non-trivial puzzle).
        """
        return self.iterations / self.elapsed_seconds
