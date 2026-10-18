"""Chronolock — a time-locked vault secured by cryptographic proof-of-work.

Bury a secret. The vault is locked not by a countdown timer but by *work*:
a sequential hash-chain puzzle that takes a chosen amount of compute to solve.
Until that work has been performed, no amount of cleverness opens it.

Public API overview:
    - ``VaultMetadata`` / ``Vault``       — in-memory representations of a vault
    - ``bury(...)``                       — create a new locked vault
    - ``open_vault(...)``                 — solve the puzzle and reveal the secret
    - ``list_vaults(...)`` / ``status``   — inspect the vault store

.. note::
    Pre-alpha (0.1). All MVP tickets in ``TICKETS.md`` are implemented; the
    on-disk format may still change before 1.0.
"""

from __future__ import annotations

from . import crypto, difficulty, errors, puzzle, store, ui, vault  # noqa: F401
from .errors import (  # noqa: F401
    ChronolockError,
    ConfigError,
    CorruptVaultError,
    IntegrityError,
    InvalidSecretError,
    PuzzleError,
    UnknownFormatError,
    VaultExistsError,
    VaultNotFoundError,
)
from .model import UnlockResult, Vault, VaultMetadata, VaultStatus  # noqa: F401

__version__ = "0.1.0"

#: The command-line interface entry point (used by the ``chronolock`` script).
__all__ = [
    # version
    "__version__",
    # model
    "VaultMetadata",
    "Vault",
    "UnlockResult",
    "VaultStatus",
    # errors
    "ChronolockError",
    "VaultNotFoundError",
    "VaultExistsError",
    "CorruptVaultError",
    "UnknownFormatError",
    "IntegrityError",
    "PuzzleError",
    "InvalidSecretError",
    "ConfigError",
    # submodules (public surface)
    "errors",
    "puzzle",
    "crypto",
    "vault",
    "store",
    "difficulty",
    "ui",
]
