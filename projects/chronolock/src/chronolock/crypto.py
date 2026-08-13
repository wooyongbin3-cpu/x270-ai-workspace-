"""Symmetric encryption and integrity protection for vault secrets.

This module turns a puzzle solution (the final chained hash from
:mod:`chronolock.puzzle`) into a working encryption key, encrypts and
decrypts secrets, and binds the ciphertext to the vault's header so that
tampering is detectable.

Cryptographic design (see SPEC.md §5 and docs/ARCHITECTURE.md):

    - **Key derivation** — HKDF-SHA256 over the puzzle's final hash, with a
      context string so keys are never reused across purposes.
    - **Encryption** — AES-256-GCM (authenticated encryption). The nonce is
      generated fresh per encryption with a CSPRNG.
    - **Integrity** — GCM already provides authenticity of the ciphertext.
      We additionally compute an HMAC-SHA256 over the *encrypted payload
      (nonce + ciphertext + tag)* so the storage layer can detect corruption
      quickly, *before* attempting an expensive decrypt.

All nonce material is intentionally **not** bound to the puzzle: the puzzle
only derives the key. Re-serializing with the same key (same seed +
difficulty) under a fresh nonce produces valid, distinct ciphertext with the
same plaintext — this is fine because the puzzle itself is deterministic;
freshness comes from the nonce.

.. note::
    Nothing in this module ever logs or prints key material. Keep it that
    way — plaintext secrets and derived keys are secret.
"""

from __future__ import annotations

import os
from dataclasses import dataclass
from typing import Optional

#: Context string used to scope the HKDF key derivation. Changing this
#: invalidates all existing vaults — never change it without a migration.
_KEY_CONTEXT = b"chronolock/v1/aes-256-gcm"

#: Length (bytes) of the AES-256 key derived via HKDF.
KEY_LENGTH = 32

#: Length (bytes) of a GCM nonce.
NONCE_LENGTH = 12

#: Length (bytes) of the GCM authentication tag.
TAG_LENGTH = 16

#: Maximum size (bytes) of a secret payload. 256 KiB is plenty for a
#: "letter to the future" and keeps vault files small.
MAX_SECRET_BYTES = 256 * 1024

#: Length (bytes) of the HMAC-SHA256 integrity tag.
HMAC_LENGTH = 32


@dataclass(frozen=True)
class EncryptedSecret:
    """A sealed secret: everything needed to decrypt it except the key.

    Attributes:
        ciphertext: The raw ciphertext bytes (no nonce/tag).
        nonce: The GCM nonce used for encryption.
        tag: The GCM authentication tag.
        hmac: HMAC-SHA256 over ``nonce + ciphertext + tag``, keyed with a
            derived integrity key (see :func:`derive_keys`).
    """

    ciphertext: bytes
    nonce: bytes
    tag: bytes
    hmac: bytes


def derive_keys(puzzle_final_hash: bytes) -> "tuple[bytes, bytes]":
    """Derive the encryption key and integrity key from a puzzle solution.

    Uses HKDF-SHA256 with a fixed context string and two distinct info labels
    so the encryption key and integrity key are never identical.

    Args:
        puzzle_final_hash: The final chained hash from the puzzle solver.

    Returns:
        A ``(encryption_key, integrity_key)`` tuple, each 32 bytes.
    """
    # TODO(TICKET-003): implement via HKDF from cryptography.hazmat.
    #   - info = _KEY_CONTEXT + b":enc"  for the encryption key
    #   - info = _KEY_CONTEXT + b":mac"  for the integrity key
    #   - length = KEY_LENGTH for both
    raise NotImplementedError


def encrypt(plaintext: str, puzzle_final_hash: bytes) -> EncryptedSecret:
    """Encrypt a plaintext secret under a puzzle-derived key.

    Args:
        plaintext: The secret text to seal. Must not exceed
            ``MAX_SECRET_BYTES`` when UTF-8 encoded.
        puzzle_final_hash: The puzzle solution to derive the key from.

    Returns:
        An :class:`EncryptedSecret` containing the ciphertext, nonce, tag,
        and integrity HMAC.

    Raises:
        InvalidSecretError: If the plaintext is empty or too large.
    """
    # TODO(TICKET-003): implement —
    #   1. validate size, encode to UTF-8
    #   2. derive (enc_key, mac_key) via derive_keys
    #   3. AESGCM(enc_key).encrypt(nonce=os.urandom(NONCE_LENGTH), data=payload, aad=b"")
    #   4. hmac = HMAC-SHA256(mac_key, nonce + ciphertext + tag)
    #   5. return EncryptedSecret(...)
    raise NotImplementedError


def decrypt(encrypted: EncryptedSecret, puzzle_final_hash: bytes) -> str:
    """Decrypt and authenticate a previously sealed secret.

    Verifies the integrity HMAC first (cheap, no AES), then decrypts. If the
    HMAC does not verify, the ciphertext was tampered with or corrupted.

    Args:
        encrypted: The sealed secret to open.
        puzzle_final_hash: The puzzle solution to derive the key from.

    Returns:
        The recovered plaintext string.

    Raises:
        IntegrityError: If the HMAC does not verify (tampering/corruption).
        cryptography.exceptions.InvalidTag: If GCM authentication fails.
    """
    # TODO(TICKET-003): implement —
    #   1. derive (enc_key, mac_key)
    #   2. recompute HMAC over nonce + ciphertext + tag; raise IntegrityError on mismatch
    #      (use a constant-time comparison!)
    #   3. AESGCM(enc_key).decrypt(nonce, ciphertext + tag, aad=b"")
    #   4. decode UTF-8 and return
    raise NotImplementedError


def compute_hmac(key: bytes, data: bytes) -> bytes:
    """Compute an HMAC-SHA256 for integrity verification.

    Provides a raw building block used by the storage layer to bind vault
    headers to their payloads.

    Args:
        key: The HMAC key (32 bytes).
        data: The bytes to authenticate.

    Returns:
        The 32-byte HMAC digest.
    """
    # TODO(TICKET-003): implement via hmac.new(key, data, hashlib.sha256).
    raise NotImplementedError


def secure_wipe(data: bytearray) -> None:
    """Best-effort overwrite of secret bytes in memory.

    Python cannot guarantee that bytes are wiped (bounded immutability,
    copies in the interpreter), but overwriting a ``bytearray`` in-place is
    a reasonable best effort. Call this on memory buffers holding plaintext
    secrets once you are done with them and no copies remain.

    Args:
        data: Mutable bytearray whose contents should be zeroed.
    """
    # TODO(TICKET-003): implement — fill with zeros, then reallocate to size 0.
    raise NotImplementedError