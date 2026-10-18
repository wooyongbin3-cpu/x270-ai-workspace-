"""Vault persistence: the on-disk container format and file operations.

This module owns everything about how a vault looks on disk:

    - The vault container format (versioned JSON envelope + base64 payloads)
    - Reading/writing vault files
    - Enumerating and validating the vault store directory
"""

from __future__ import annotations

import base64
import contextlib
import json
import os
import uuid
from dataclasses import dataclass
from typing import Any

from .crypto import HMAC_LENGTH, NONCE_LENGTH, TAG_LENGTH, EncryptedSecret
from .errors import (
    ConfigError,
    CorruptVaultError,
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

    def _vault_path(self, vault_id: str) -> str:
        """Return the on-disk path of the vault file for ``vault_id``."""
        return os.path.join(self._directory, f"{vault_id}{VAULT_EXTENSION}")

    def save(self, metadata: VaultMetadata, encrypted: EncryptedSecret, seed: bytes = b"") -> None:
        """Persist a new vault to disk atomically.

        Args:
            metadata: The vault's public metadata.
            encrypted: The sealed secret payload.
            seed: The puzzle seed bytes (stored in plaintext in the header).

        Raises:
            VaultExistsError: If a vault with the same id is already stored.
            StoreIOError: If the underlying filesystem operation fails.
        """
        _validate_metadata(metadata)
        vault_id = metadata.vault_id
        fpath = self._vault_path(vault_id)
        if os.path.exists(fpath):
            raise VaultExistsError(f"vault already exists: {vault_id}")
        vault_dict = {
            "format": FORMAT,
            "version": FORMAT_VERSION,
            "seed": _b64(seed),
            "difficulty": metadata.difficulty,
            "solver_version": metadata.solver_version,
            "metadata": {
                "vault_id": metadata.vault_id,
                "name": metadata.name,
                "created_at": metadata.created_at,
                "unlock_after": metadata.unlock_after,
                "ciphertext_len": metadata.ciphertext_len,
                "status": metadata.status.value,
                "difficulty": metadata.difficulty,
                "solver_version": metadata.solver_version,
            },
            "encrypted": {
                "ciphertext": _b64(encrypted.ciphertext),
                "nonce": _b64(encrypted.nonce),
                "tag": _b64(encrypted.tag),
                "hmac": _b64(encrypted.hmac),
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
            with contextlib.suppress(OSError):
                os.remove(tmp_path)
            raise StoreIOError(f"failed to save vault {vault_id}", fpath, exc) from exc

    def _read_envelope(self, vault_id: str) -> dict[str, Any]:
        """Read and parse a vault file, validating its format/version."""
        fpath = self._vault_path(vault_id)
        try:
            with open(fpath, "rb") as fh:
                raw = fh.read()
        except FileNotFoundError:
            raise VaultNotFoundError(f"vault not found: {vault_id}", vault_id) from None
        except OSError as exc:
            raise StoreIOError(f"failed to read vault {vault_id}", fpath, exc) from exc
        try:
            data = json.loads(raw.decode("utf-8"))
        except (ValueError, UnicodeDecodeError) as exc:
            raise CorruptVaultError(f"invalid JSON in vault {vault_id}") from exc
        if not isinstance(data, dict):
            raise CorruptVaultError(f"vault {vault_id} is not a JSON object")
        if data.get("format") != FORMAT or data.get("version") != FORMAT_VERSION:
            raise UnknownFormatError(
                f"unknown format/version: {data.get('format')!r} v{data.get('version')}"
            )
        return data

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
        data = self._read_envelope(vault_id)
        metadata = _parse_metadata(data)
        try:
            enc = data["encrypted"]
            seed = _unb64(data.get("seed", ""))
            encrypted = EncryptedSecret(
                ciphertext=_unb64(enc["ciphertext"]),
                nonce=_unb64(enc["nonce"], NONCE_LENGTH),
                tag=_unb64(enc["tag"], TAG_LENGTH),
                hmac=_unb64(enc["hmac"], HMAC_LENGTH),
            )
        except (KeyError, TypeError, ValueError) as exc:
            raise CorruptVaultError(f"malformed vault payload: {exc}") from exc
        return LoadedVault(metadata=metadata, encrypted=encrypted, seed=seed)

    def load_metadata(self, vault_id: str) -> VaultMetadata:
        """Load only a vault's metadata header (no payload decode)."""
        return _parse_metadata(self._read_envelope(vault_id))

    def list_ids(self) -> list[str]:
        """List the vault ids present in the store, sorted."""
        try:
            entries = os.listdir(self._directory)
        except OSError as exc:
            raise StoreIOError("failed to list store directory", self._directory, exc) from exc
        ids = [name[: -len(VAULT_EXTENSION)] for name in entries if name.endswith(VAULT_EXTENSION)]
        return sorted(ids)

    def list_metadata(self) -> list[VaultMetadata]:
        """List metadata for every vault in the store, newest first."""
        result: list[VaultMetadata] = []
        for vid in self.list_ids():
            try:
                result.append(self.load_metadata(vid))
            except (CorruptVaultError, VaultNotFoundError):
                continue
        result.sort(key=lambda m: m.created_at, reverse=True)
        return result


def _b64(data: bytes) -> str:
    """Encode bytes as ASCII base64."""
    return base64.b64encode(data).decode("ascii")


def _unb64(text: str, expected_len: int | None = None) -> bytes:
    """Strictly decode base64, optionally checking the decoded length.

    Raises:
        ValueError: On invalid base64 or an unexpected length.
    """
    decoded = base64.b64decode(text, validate=True)
    if expected_len is not None and len(decoded) != expected_len:
        raise ValueError(f"expected {expected_len} bytes, got {len(decoded)}")
    return decoded


def _parse_metadata(data: dict[str, Any]) -> VaultMetadata:
    """Build :class:`VaultMetadata` from a parsed vault envelope."""
    try:
        meta = data["metadata"]
        return VaultMetadata(
            vault_id=meta["vault_id"],
            name=meta["name"],
            created_at=meta["created_at"],
            unlock_after=meta["unlock_after"],
            difficulty=meta.get("difficulty", data.get("difficulty")),
            ciphertext_len=meta["ciphertext_len"],
            status=VaultStatus(meta["status"]),
            solver_version=meta.get("solver_version", SOLVER_VERSION),
        )
    except (KeyError, TypeError, ValueError) as exc:
        raise CorruptVaultError(f"malformed vault header: {exc}") from exc


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


def generate_vault_id(entropy_source: Any | None = None) -> str:
    """Generate a unique vault id (hex, 32 chars)."""
    src = entropy_source if entropy_source is not None else uuid.uuid4
    return src().hex
