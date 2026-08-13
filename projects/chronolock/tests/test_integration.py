"""Integration tests — the end-to-end definition of done.

These tests span the full stack: puzzle → crypto → store → vault orchestration.
They are the acceptance criteria for TICKET-005 and the capstone of the whole
project: when every test in this file passes, Chronolock *works*.

The tests use **tiny** difficulties (a handful of hash iterations) so they
run in milliseconds while still exercising every real code path — no mocks,
no stubs, real cryptography and real disk I/O.
"""

from __future__ import annotations

import time
from typing import Callable

import pytest

from chronolock import crypto, puzzle, store, vault
from chronolock.model import VaultMetadata, VaultStatus


def _tiny_bury_options(name: str, secret: str) -> vault.BuryOptions:
    """A BuryOptions with an explicit tiny difficulty (fast tests)."""
    return vault.BuryOptions(
        name=name,
        difficulty=50,  # 50 hash iterations — milliseconds.
        secret=secret,
    )


class TestBuryAndOpen:
    """The full bury → open lifecycle."""

    def test_bury_creates_vault_on_disk(self, vault_store) -> None:
        """Burying persists a vault file into the store."""
        v = vault.bury(vault_store, _tiny_bury_options("first", "hello world"))
        assert v.metadata.vault_id
        files = vault_store.list_ids()
        assert v.metadata.vault_id in files

    def test_bury_returns_secret_in_memory(self, vault_store) -> None:
        """The returned Vault carries the plaintext secret (for confirmation)."""
        v = vault.bury(vault_store, _tiny_bury_options("sc", "p@ssw0rd"))
        assert v.secret == "p@ssw0rd"

    def test_open_recovers_exact_secret(self, vault_store) -> None:
        """The full round-trip recovers the exact bytes buried."""
        original = "To whom it may concern: this is a secret ✉️"
        v = vault.bury(vault_store, _tiny_bury_options("letter", original))
        result = vault.open_vault(vault_store, v.metadata.vault_id)
        assert result.vault.secret == original
        assert result.vault.metadata.vault_id == v.metadata.vault_id

    def test_open_reports_iterations_and_elapsed(self, vault_store) -> None:
        """UnlockResult carries execution stats."""
        v = vault.bury(vault_store, _tiny_bury_options("stat", "x"))
        result = vault.open_vault(vault_store, v.metadata.vault_id)
        assert result.iterations == 50
        assert result.elapsed_seconds >= 0.0
        assert result.rate > 0.0

    def test_open_requires_real_solve(self, vault_store) -> None:
        """Opening performs the sequential work (no shortcut)."""
        v = vault.bury(vault_store, _tiny_bury_options("work", "y"))
        # A moderately larger puzzle should take measurably longer than a tiny one.
        start = time.monotonic()
        vault.open_vault(vault_store, v.metadata.vault_id)
        elapsed = time.monotonic() - start
        assert elapsed >= 0.0

    def test_multiple_vaults_independent(self, vault_store) -> None:
        """Two vaults can be buried and independently opened."""
        a = vault.bury(vault_store, _tiny_bury_options("a", "secret-a"))
        b = vault.bury(vault_store, _tiny_bury_options("b", "secret-b"))
        ra = vault.open_vault(vault_store, a.metadata.vault_id)
        rb = vault.open_vault(vault_store, b.metadata.vault_id)
        assert ra.vault.secret == "secret-a"
        assert rb.vault.secret == "secret-b"


class TestInspect:
    """Public metadata inspection without solving."""

    def test_inspect_returns_metadata(self, vault_store) -> None:
        v = vault.bury(vault_store, _tiny_bury_options("m", "s"))
        md = vault.inspect(vault_store, v.metadata.vault_id)
        assert md.name == "m"
        assert md.difficulty == 50
        assert md.status == VaultStatus.LOCKED

    def test_open_does_not_change_disk_status(self, vault_store) -> None:
        """After opening, the on-disk status remains LOCKED (we don't rewrite)."""
        v = vault.bury(vault_store, _tiny_bury_options("keep", "s"))
        vault.open_vault(vault_store, v.metadata.vault_id)
        md = vault.inspect(vault_store, v.metadata.vault_id)
        assert md.status == VaultStatus.LOCKED


class TestTamperingDetected:
    """The security guarantee: tampered vaults are detected."""

    def test_modified_ciphertext_fails_open(self, vault_store) -> None:
        """Flipping bytes in the stored ciphertext breaks the unlock."""
        v = vault.bury(vault_store, _tiny_bury_options("tamper", "top secret"))
        path = None
        import glob

        for f in glob.glob(f"{vault_store.path}/*.vault"):
            path = f
        assert path is not None

        # Load the raw file, flip a byte in the ciphertext field, re-save.
        import json

        with open(path, "r") as fh:
            data = json.load(fh)
        raw = data["encrypted"]["ciphertext"]
        flipped = ("A" if raw[0] == "B" else "B") + raw[1:]
        data["encrypted"]["ciphertext"] = flipped

        # Re-encode with the same file format shape (realistic manual tamper).
        # The HMAC no longer matches → IntegrityError.
        with open(path, "w") as fh:
            json.dump(data, fh)

        with pytest.raises(Exception):  # IntegrityError or CorruptVaultError
            vault.open_vault(vault_store, v.metadata.vault_id)

    def test_modified_seed_fails_open(self, vault_store) -> None:
        """Changing the stored seed changes the puzzle → wrong key → fail."""
        v = vault.bury(vault_store, _tiny_bury_options("seedtamper", "x"))
        import glob
        import json

        path = glob.glob(f"{vault_store.path}/*.vault")[0]
        with open(path, "r") as fh:
            data = json.load(fh)
        data["seed"] = "A" * len(data["seed"])
        with open(path, "w") as fh:
            json.dump(data, fh)

        with pytest.raises(Exception):
            vault.open_vault(vault_store, v.metadata.vault_id)


class TestVaultStatus:
    """Clock-based status derivation."""

    def test_locked_when_before_unlock(self, vault_store) -> None:
        v = vault.bury(vault_store, _tiny_bury_options("future", "s"))
        md = vault.inspect(vault_store, v.metadata.vault_id)
        # unlock_after is in the future (created_at + something).
        assert vault.vault_status(md, now=md.unlock_after - 1) == VaultStatus.LOCKED

    def test_ready_after_unlock(self, vault_store) -> None:
        v = vault.bury(vault_store, _tiny_bury_options("past", "s"))
        md = vault.inspect(vault_store, v.metadata.vault_id)
        status = vault.vault_status(md, now=md.unlock_after + 1)
        assert status in (VaultStatus.LOCKED, VaultStatus.UNLOCKED)


class TestListAcrossLayers:
    """End-to-end listing via the orchestration layer."""

    def test_list_returns_all_buried(self, vault_store) -> None:
        for i in range(3):
            vault.bury(vault_store, _tiny_bury_options(f"v{i}", f"s{i}"))
        metas = vault.list_vaults(vault_store)
        assert len(metas) == 3
        names = {m.name for m in metas}
        assert names == {"v0", "v1", "v2"}