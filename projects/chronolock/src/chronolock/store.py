"""Vault persistence: the on-disk container format and file operations.

This module owns everything about how a vault looks on disk:

    - The vault container format (versioned JSON envelope + base64 payloads)
    - Reading/writing vault files
    - Enumerating and validating the vault store directory
"""

from __future__ import annotations

import base64
import hashlib
import json
import os
import time
import uuid
from dataclasses import dataclass
from typing import Any, Dict, List, Optional

from .crypto import EncryptedSecret, compute_hmac
from .errors import (
    ConfigError,
    CorruptVaultError,
    MultiVaultError,
    StoreIOError,
    UnknownFormatError,
    VaultExistsError,
    VaultNotFoundError,
)
from .model import VaultMetadata, VaultStatus
from .puzzle import SOLVER_VERSION

FORMAT = "chronolock-vault"
FORMAT_VERSION = 1
VAULT_EXTENSION = ".vault"


@dataclass(frozen=True)
class LoadedVault:
    """A vault as loaded from disk: its metadata plus its sealed payload.

    Attributes:
        metadata: The vault's public metadata (from the header).
        encrypted: The sealed secret payload.
        seed: The puzzle seed bytes (base64-decoded from the vault file).
    """

    metadata: VaultMetadata
    encrypted: EncryptedSecret
    seed: bytes


class VaultStore:
    """A directory on disk containing ``.vault`` files."""

    def __init__(self, directory: str) -> None:
        if directory.startswith("~/"):
            home = os.environ.get("HOME") or os.environ.get("USERPROFILE", "")
            directory = os.path.join(home, directory[2:])
        expanded = os.path.expanduser(directory)
        abs_path = os.path.abspath(expanded)
        if os.path.exists(abs_path) and not os.path.isdir(abs_path):
            raise ConfigError(f"store path exists but is not a directory: {abs_path}")
        os.makedirs(abs_path, exist_ok=True)
        self._directory = abs_path

    @property
    def path(self) -> str:
        """Return the absolute path of the store directory."""
        return self._directory

    def save(self, metadata: VaultMetadata, encrypted: EncryptedSecret, seed: bytes = b"") -> None:
        """Persist a vault to disk atomically.

        Args:
            metadata: The vault's public metadata.
            encrypted: The sealed secret payload.
            seed: The puzzle seed bytes (stored in plaintext in the header).

        Raises:
            StoreIOError: If the underlying filesystem operation fails.
        """
        _validate_metadata(metadata)
        vault_id = metadata.vault_id
        fpath = os.path.join(self._directory, f"{vault_id}{VAULT_EXTENSION}")
        metadata_dict = {
            "vault_id": metadata.vault_id,
            "name": metadata.name,
            "created_at": metadata.created_at,
            "unlock_after": metadata.unlock_after,
            "ciphertext_len": metadata.ciphertext_len,
            "status": metadata.status.value,
            "difficulty": metadata.difficulty,
            "solver_version": metadata.solver_version,
        }
        vault_dict = {
            "format": FORMAT,
            "version": FORMAT_VERSION,
            "seed": base64.b64encode(seed).decode("ascii"),
            "difficulty": metadata.difficulty,
            "solver_version": metadata.solver_version,
            "metadata": metadata_dict,
            "encrypted": {
                "ciphertext": base64.b64encode(encrypted.ciphertext).decode("ascii"),
                "nonce": base64.b64encode(encrypted.nonce).decode("ascii"),
                "tag": base64.b64encode(encrypted.tag).decode("ascii"),
                "hmac": base64.b64encode(encrypted.hmac).decode("ascii"),
            },
            "meta": None,
        }
        data = json.dumps(vault_dict, separators=(",", ":")).encode("utf-8")
        tmp_path = fpath + ".tmp"
        try:
            fd = os.open(tmp_path, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
            try:
                os.write(fd, data)
                os.fsync(fd)
            finally:
                os.close(fd)
            os.replace(tmp_path, fpath)
        except OSError as exc:
            raise StoreIOError(f"failed to save vault {vault_id}", fpath, exc) from exc

    def load(self, vault_id: str) -> LoadedVault:
        """Load a vault's metadata and sealed payload from disk.

        Args:
            vault_id: The vault identifier.

        Returns:
            A :class:`LoadedVault`.

        Raises:
            VaultNotFoundError: If no vault with that id exists.
            CorruptVaultError: If the file is malformed.
            UnknownFormatError: If the format/version is not understood.
            StoreIOError: If the underlying filesystem operation fails.
        """
        fpath = os.path.join(self._directory, f"{vault_id}{VAULT_EXTENSION}")
        try:
            raw = open(fpath, "rb").read()
        except FileNotFoundError:
            raise VaultNotFoundError(f"vault not found: {vault_id}", vault_id)
        except OSError as exc:
            raise StoreIOError(f"failed to read vault {vault_id}", fpath, exc) from exc
        try:
            data = json.loads(raw.decode("utf-8"))
        except (ValueError, UnicodeDecodeError) as exc:
            raise CorruptVaultError(f"invalid JSON in vault {vault_id}") from exc
        if data.get("format") != FORMAT or data.get("version") != FORMAT_VERSION:
            raise UnknownFormatError(
                f"unknown format/version: {data.get('format')!r} v{data.get('version')}"
            )
        try:
            meta = data["metadata"]
            enc = data["encrypted"]
            seed = base64.b64decode(data.get("seed", ""))
            metadata = VaultMetadata(
                vault_id=meta["vault_id"],
                name=meta["name"],
                created_at=meta["created_at"],
                unlock_after=meta["unlock_after"],
                difficulty=meta["difficulty"],
                ciphertext_len=meta["ciphertext_len"],
                status=VaultStatus(meta["status"]),
                solver_version=meta.get("solver_version", SOLVER_VERSION),
            )
            encrypted = EncryptedSecret(
                ciphertext=base64.b64decode(enc["ciphertext"]),
                nonce=base64.b64decode(enc["nonce"]),
                tag=base64.b64decode(enc["tag"]),
                hmac=base64.b64decode(enc["hmac"]),
            )
        except (KeyError, TypeError, ValueError) as exc:
            raise CorruptVaultError(f"malformed vault payload: {exc}") from exc
        return LoadedVault(metadata=metadata, encrypted=encrypted, seed=seed)

    def load_metadata(self, vault_id: str) -> VaultMetadata:
        """Load only a vault's metadata header (no payload decode)."""
        fpath = os.path.join(self._directory, f"{vault_id}{VAULT_EXTENSION}")
        try:
            raw = open(fpath, "rb").read()
        except FileNotFoundError:
            raise VaultNotFoundError(f"vault not found: {vault_id}", vault_id)
        except OSError as exc:
            raise StoreIOError(f"failed to read vault {vault_id}", fpath, exc) from exc
        try:
            data = json.loads(raw.decode("utf-8"))
        except (ValueError, UnicodeDecodeError) as exc:
            raise CorruptVaultError(f"invalid JSON in vault {vault_id}") from exc
        if data.get("format") != FORMAT or data.get("version") != FORMAT_VERSION:
            raise UnknownFormatError(
                f"unknown format/version: {data.get('format')!r} v{data.get('version')}"
            )
        try:
            meta = data["metadata"]
            return VaultMetadata(
                vault_id=meta["vault_id"],
                name=meta["name"],
                created_at=meta["created_at"],
                unlock_after=meta["unlock_after"],
                difficulty=meta["difficulty"],
                ciphertext_len=meta["ciphertext_len"],
                status=VaultStatus(meta["status"]),
                solver_version=meta.get("solver_version", SOLVER_VERSION),
            )
        except (KeyError, TypeError, ValueError) as exc:
            raise CorruptVaultError(f"malformed vault header: {exc}") from exc

    def list_ids(self) -> List[str]:
        """List the vault ids present in the store, sorted."""
        try:
            entries = os.listdir(self._directory)
        except OSError as exc:
            raise StoreIOError("failed to list store directory", self._directory, exc) from exc
        ids = [
            name[: -len(VAULT_EXTENSION)]
            for name in entries
            if name.endswith(VAULT_EXTENSION)
        ]
        return sorted(ids)

    def list_metadata(self) -> List[VaultMetadata]:
        """List metadata for every vault in the store, newest first."""
        result: List[VaultMetadata] = []
        for vid in self.list_ids():
            try:
                result.append(self.load_metadata(vid))
            except (CorruptVaultError, UnknownFormatError, VaultNotFoundError):
                continue
        result.sort(key=lambda m: m.created_at, reverse=True)
        return result


def _validate_metadata(metadata: VaultMetadata) -> None:
    """Validate the shape of a metadata object before serialization."""
    if not isinstance(metadata.vault_id, str) or not metadata.vault_id:
        raise CorruptVaultError("vault_id must be a non-empty string")
    if not isinstance(metadata.name, str) or not metadata.name:
        raise CorruptVaultError("name must be a non-empty string")
    if not isinstance(metadata.created_at, int) or metadata.created_at <= 0:
        raise CorruptVaultError("created_at must be a positive integer")
    if not isinstance(metadata.unlock_after, int) or metadata.unlock_after <= 0:
        raise CorruptVaultError("unlock_after must be a positive integer")
    if not isinstance(metadata.difficulty, int) or metadata.difficulty <= 0:
        raise CorruptVaultError("difficulty must be a positive integer")
    if not isinstance(metadata.ciphertext_len, int) or metadata.ciphertext_len < 0:
        raise CorruptVaultError("ciphertext_len must be a non-negative integer")
    if not isinstance(metadata.status, VaultStatus):
        raise CorruptVaultError("status must be a VaultStatus")
    if metadata.status not in (VaultStatus.LOCKED, VaultStatus.SOLVING, VaultStatus.UNLOCKED):
        raise CorruptVaultError(f"invalid status: {metadata.status}")


def default_store_path() -> str:
    """Return the default vault store directory path."""
    env_path = os.environ.get("CHRONOLOCK_DIR")
    if env_path:
        return os.path.abspath(env_path)
    if os.name == "nt":
        base = os.environ.get("APPDATA", os.path.expanduser("~"))
    elif os.name == "posix":
        import platform
        if platform.system() == "Darwin":
            base = os.path.join(os.path.expanduser("~"), "Library", "Application Support")
        else:
            base = os.path.join(os.path.expanduser("~"), ".local", "share")
    else:
        base = os.path.join(os.path.expanduser("~"), ".chronolock")
    return os.path.join(base, "chronolock")


def generate_vault_id(entropy_source: Optional[Any] = None) -> str:
    """Generate a unique vault id (hex, 32 chars)."""
    src = entropy_source if entropy_source is not None else uuid.uuid4
    return src().hex
