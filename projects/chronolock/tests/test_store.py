"""Tests for :mod:`chronolock.store` — vault persistence and container format.

Covers:
    - store creation and path handling
    - save → load round-trip
    - atomic writes (no partial files on failure)
    - load/format/structural error handling (missing, corrupt, unknown)
    - listing behaviour (ids + metadata ordering)
    - vault id generation
    - default store path resolution (env/OS)
"""

from __future__ import annotations

import json
import os
from pathlib import Path
from typing import Any, Callable

import pytest

from chronolock import store
from chronolock.errors import (
    ConfigError,
    CorruptVaultError,
    StoreIOError,
    UnknownFormatError,
    VaultExistsError,
    VaultNotFoundError,
)
from chronolock.model import VaultMetadata


class TestVaultStoreInit:
    """Store directory creation and validation."""

    def test_creates_directory(self, tmp_path: Path) -> None:
        """A missing store directory is created."""
        target = tmp_path / "new" / "deep" / "store"
        s = store.VaultStore(str(target))
        assert target.is_dir()
        assert s.path == str(target.resolve())

    def test_accepts_existing_directory(self, tmp_path: Path) -> None:
        """An existing directory is accepted (no-op)."""
        target = tmp_path / "exists"
        target.mkdir()
        s = store.VaultStore(str(target))
        assert s.path == str(target.resolve())

    def test_tilde_expansion(self, tmp_path: Path, monkeypatch) -> None:
        """``~`` in the path is expanded to the home directory."""
        monkeypatch.setenv("HOME", str(tmp_path / "home"))
        s = store.VaultStore("~/chrono-tests")
        assert s.path == str((tmp_path / "home" / "chrono-tests").resolve())

    def test_path_is_file_raises(self, tmp_path: Path) -> None:
        """Passing a regular file raises ConfigError."""
        f = tmp_path / "file"
        f.write_text("x")
        with pytest.raises(ConfigError):
            store.VaultStore(str(f))


class TestSaveLoad:
    """Round-trip persistence via the store."""

    def test_save_creates_file(self, vault_store, sample_metadata, sealed_secret) -> None:
        """Saving writes a `.vault` file on disk."""
        vault_store.save(sample_metadata, sealed_secret)
        path = Path(vault_store.path) / f"{sample_metadata.vault_id}{store.VAULT_EXTENSION}"
        assert path.is_file()

    def test_round_trip(self, vault_store, sample_metadata, sealed_secret) -> None:
        """A saved vault loads back with identical metadata and payload."""
        vault_store.save(sample_metadata, sealed_secret)
        loaded = vault_store.load(sample_metadata.vault_id)
        assert loaded.metadata == sample_metadata
        assert loaded.encrypted == sealed_secret

    def test_save_overwrite_raises(self, vault_store, sample_metadata, sealed_secret) -> None:
        """Saving twice with the same id raises VaultExistsError."""
        vault_store.save(sample_metadata, sealed_secret)
        with pytest.raises(VaultExistsError):
            vault_store.save(sample_metadata, sealed_secret)

    def test_load_missing_raises(self, vault_store) -> None:
        """Loading a non-existent id raises VaultNotFoundError."""
        with pytest.raises(VaultNotFoundError):
            vault_store.load("deadbeef" * 4)

    def test_load_metadata_round_trip(self, vault_store, sample_metadata, sealed_secret) -> None:
        """``load_metadata`` returns the header without touching the payload."""
        vault_store.save(sample_metadata, sealed_secret)
        md = vault_store.load_metadata(sample_metadata.vault_id)
        assert md == sample_metadata


class TestAtomicity:
    """Writes must never leave a partially-written vault."""

    def test_no_temp_files_left(self, vault_store, sample_metadata, sealed_secret) -> None:
        """No `*.tmp` files remain after a successful save."""
        vault_store.save(sample_metadata, sealed_secret)
        leftovers = list(Path(vault_store.path).glob("*.tmp"))
        assert leftovers == []

    def test_save_replaces_existing(self, vault_store, sample_metadata, sealed_secret) -> None:
        """Overwriting is atomic: old content is fully replaced."""
        vault_store.save(sample_metadata, sealed_secret)
        # Modify the file directly, then re-save; the file must be whole again.
        path = Path(vault_store.path) / f"{sample_metadata.vault_id}{store.VAULT_EXTENSION}"
        path.write_text("{broken")
        vault_store.save(sample_metadata, sealed_secret)
        loaded = vault_store.load(sample_metadata.vault_id)
        assert loaded.metadata.vault_id == sample_metadata.vault_id


class TestCorruption:
    """Malformed vault files must raise the right errors."""

    def _write_raw(self, store_dir: Path, vault_id: str, content: str) -> Path:
        path = store_dir / f"{vault_id}{store.VAULT_EXTENSION}"
        path.write_text(content)
        return path

    def test_not_json_raises_corrupt(self, vault_store, tmp_path) -> None:
        """Non-JSON content raises CorruptVaultError."""
        self._write_raw(Path(vault_store.path), "not json at all", "x" * 32)
        with pytest.raises(CorruptVaultError):
            vault_store.load("x" * 32)

    def test_missing_fields_raises_corrupt(self, vault_store) -> None:
        """A JSON object missing required fields raises CorruptVaultError."""
        self._write_raw(Path(vault_store.path), '{"format": "chronolock-vault"}', "y" * 32)
        with pytest.raises(CorruptVaultError):
            vault_store.load("y" * 32)

    def test_unknown_format_raises(self, vault_store) -> None:
        """A container with an unknown format string raises UnknownFormatError."""
        self._write_raw(
            Path(vault_store.path),
            json.dumps({"format": "something-else", "version": 1}),
            "z" * 32,
        )
        with pytest.raises(UnknownFormatError):
            vault_store.load("z" * 32)

    def test_invalid_base64_raises_corrupt(self, vault_store, sample_metadata) -> None:
        """Bad base64 in a payload field raises CorruptVaultError."""
        payload = {
            "format": store.FORMAT,
            "version": store.FORMAT_VERSION,
            "seed": "!!!not-base64!!!",
            "difficulty": 10,
            "solver_version": "puzzle-v1",
            "metadata": {
                "vault_id": sample_metadata.vault_id,
                "name": sample_metadata.name,
                "created_at": sample_metadata.created_at,
                "unlock_after": sample_metadata.unlock_after,
                "ciphertext_len": sample_metadata.ciphertext_len,
                "status": sample_metadata.status.value,
            },
            "encrypted": {
                "ciphertext": "AAAA",
                "nonce": "AAAA",
                "tag": "AAAA",
                "hmac": "AAAA",
            },
            "meta": None,
        }
        self._write_raw(
            Path(vault_store.path),
            json.dumps(payload),
            sample_metadata.vault_id,
        )
        with pytest.raises(CorruptVaultError):
            vault_store.load(sample_metadata.vault_id)


class TestListing:
    """Store enumeration."""

    def test_list_ids_empty(self, vault_store) -> None:
        """A fresh store lists no vaults."""
        assert vault_store.list_ids() == []

    def test_list_ids_sorted(self, vault_store, sample_metadata, sealed_secret) -> None:
        """Ids come back sorted."""
        ids = [f"{i:032d}" for i in (3, 1, 2)]
        for vid in ids:
            md = VaultMetadata(
                vault_id=vid,
                name=f"v{vid}",
                created_at=1_700_000_000,
                unlock_after=1_700_000_000 + 1000,
                difficulty=10,
                ciphertext_len=1,
            )
            vault_store.save(md, sealed_secret)
        assert vault_store.list_ids() == sorted(ids)

    def test_list_metadata_newest_first(self, vault_store, sealed_secret) -> None:
        """Metadata listing is ordered by created_at descending."""
        for i, ts in enumerate((3_000, 1_000, 2_000)):
            md = VaultMetadata(
                vault_id=f"{i:032d}",
                name=f"v{i}",
                created_at=ts,
                unlock_after=ts + 1000,
                difficulty=10,
                ciphertext_len=1,
            )
            vault_store.save(md, sealed_secret)
        created = [m.created_at for m in vault_store.list_metadata()]
        assert created == [3_000, 2_000, 1_000]

    def test_list_skips_corrupt(self, vault_store, sealed_secret) -> None:
        """Vaults with unparseable headers are skipped, not fatal."""
        # One good vault …
        good = VaultMetadata(
            vault_id="0" * 32,
            name="good",
            created_at=1_000,
            unlock_after=2_000,
            difficulty=10,
            ciphertext_len=1,
        )
        vault_store.save(good, sealed_secret)
        # … one corrupt.
        (Path(vault_store.path) / f"{'f' * 32}{store.VAULT_EXTENSION}").write_text("garbage")
        metas = vault_store.list_metadata()
        assert [m.vault_id for m in metas] == [good.vault_id]


class TestVaultId:
    """Vault id generation."""

    def test_hex_length(self) -> None:
        """A generated id is 32 hex chars."""
        vid = store.generate_vault_id()
        assert len(vid) == 32
        int(vid, 16)  # raises if not hex

    def test_unique(self) -> None:
        """Ids collide with negligible probability."""
        ids = {store.generate_vault_id() for _ in range(100)}
        assert len(ids) == 100

    def test_deterministic_with_source(self) -> None:
        """An injected uuid source makes ids deterministic."""
        import uuid

        source = lambda: uuid.UUID(int=7)  # noqa: E731
        assert store.generate_vault_id(source) == "00000000000000000000000000000007"


class TestDefaultStorePath:
    """Default store location resolution."""

    def test_env_override(self, tmp_path: Path, monkeypatch) -> None:
        """``$CHRONOLOCK_DIR`` wins over everything."""
        monkeypatch.setenv("CHRONOLOCK_DIR", str(tmp_path / "env"))
        assert store.default_store_path() == str((tmp_path / "env").resolve())

    def test_env_unset_uses_platform(self, monkeypatch) -> None:
        """Without the env var, falls through to platform dir logic."""
        monkeypatch.delenv("CHRONOLOCK_DIR", raising=False)
        p = store.default_store_path()
        assert isinstance(p, str)
        assert p  # non-empty