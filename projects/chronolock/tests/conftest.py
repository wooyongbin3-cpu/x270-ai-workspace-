"""Shared pytest fixtures for the Chronolock test suite.

This module provides fixtures that are used across both unit and integration
tests. Keeping them here avoids duplication and gives every test a consistent,
isolated environment (temp vault store, deterministic entropy, etc.).

Fixture notes:
    - All fixtures avoid calling *unimplemented* production code — they build
      plain data objects directly. This keeps test setup green even while the
      implementation is still a TODO skeleton (the tests themselves will fail
      where they assert on unimplemented behaviour — that is the point).
"""

from __future__ import annotations

import sys
from pathlib import Path
from typing import Callable, Iterator

import pytest

# Ensure the package is importable when tests run from a checkout without
# installation (mirrors src-layout dev installs).
SRC_ROOT = Path(__file__).resolve().parent.parent / "src"
if str(SRC_ROOT) not in sys.path:
    sys.path.insert(0, str(SRC_ROOT))

from chronolock import crypto, puzzle, store  # noqa: E402
from chronolock.model import VaultMetadata, VaultStatus  # noqa: E402


@pytest.fixture
def entropy_source() -> Callable[[int], bytes]:
    """A deterministic entropy source returning a fixed 32-byte seed."""

    def _source(nbytes: int) -> bytes:
        # Fixed, reproducible bytes — fine for tests, never for production.
        return bytes(range(nbytes))

    return _source


@pytest.fixture
def tiny_puzzle_spec(entropy_source: Callable[[int], bytes]) -> puzzle.PuzzleSpec:
    """A tiny puzzle (difficulty 10) with a deterministic seed.

    Deliberately tiny so tests run in microseconds yet still exercise the
    full solve path.
    """
    return puzzle.PuzzleSpec(
        seed=entropy_source(32),
        difficulty=10,
    )


@pytest.fixture
def vault_store(tmp_path: Path) -> Iterator[store.VaultStore]:
    """A fresh :class:`VaultStore` rooted in a temporary directory.

    Each test gets its own clean store, so tests never interfere with each
    other or with any real vaults on disk.
    """
    s = store.VaultStore(str(tmp_path / "vaults"))
    yield s


@pytest.fixture
def sample_metadata() -> VaultMetadata:
    """A fully-populated, valid :class:`VaultMetadata` for reuse in tests."""
    return VaultMetadata(
        vault_id="0" * 32,
        name="test-vault",
        created_at=1_700_000_000,
        unlock_after=1_700_000_000 + 86_400,  # one day later
        difficulty=10,
        ciphertext_len=24,
        status=VaultStatus.LOCKED,
    )


@pytest.fixture
def sealed_secret() -> crypto.EncryptedSecret:
    """A valid-shaped sealed (encrypted) secret for storage tests.

    Constructed directly (not via the unimplemented ``crypto.encrypt``) so
    storage-layer tests can exercise save/load round-trips independently of
    the crypto implementation.
    """
    return crypto.EncryptedSecret(
        ciphertext=b"\x00" * 16,
        nonce=b"\x11" * 12,
        tag=b"\x22" * 16,
        hmac=b"\x33" * 32,
    )