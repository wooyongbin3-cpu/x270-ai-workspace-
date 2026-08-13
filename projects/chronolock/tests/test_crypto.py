"""Tests for :mod:`chronolock.crypto` — encryption and integrity.

Covers:
    - key derivation (deterministic, distinct keys for enc vs mac)
    - encrypt/decrypt round-trip
    - wrong key fails to decrypt
    - tampered ciphertext fails the HMAC integrity check
    - size validation for secrets
    - secure_wipe behaviour
"""

from __future__ import annotations

import pytest

from chronolock import crypto
from chronolock.errors import IntegrityError, InvalidSecretError

#: A fixed (deterministic) puzzle final hash used across these tests.
_TEST_FINAL = b"\xaa" * 32


class TestDeriveKeys:
    """Tests for :func:`crypto.derive_keys`."""

    def test_returns_two_keys(self) -> None:
        """Produces a tuple of two 32-byte keys."""
        enc, mac = crypto.derive_keys(_TEST_FINAL)
        assert len(enc) == crypto.KEY_LENGTH
        assert len(mac) == crypto.KEY_LENGTH

    def test_keys_are_distinct(self) -> None:
        """Encryption key and integrity key must never be equal."""
        enc, mac = crypto.derive_keys(_TEST_FINAL)
        assert enc != mac

    def test_deterministic(self) -> None:
        """Same input yields the same keys."""
        e1, m1 = crypto.derive_keys(_TEST_FINAL)
        e2, m2 = crypto.derive_keys(_TEST_FINAL)
        assert e1 == e2
        assert m1 == m2

    def test_different_input_yields_different_keys(self) -> None:
        """Different puzzle hashes yield entirely different keys."""
        e1, _ = crypto.derive_keys(b"\xaa" * 32)
        e2, _ = crypto.derive_keys(b"\xbb" * 32)
        assert e1 != e2


class TestEncryptDecrypt:
    """Round-trip and failure-mode tests for :func:`crypto.encrypt` / ``decrypt``."""

    def test_round_trip(self) -> None:
        """A secret survives a full encrypt → decrypt cycle."""
        secret = "hello, future me 👋"
        sealed = crypto.encrypt(secret, _TEST_FINAL)
        assert crypto.decrypt(sealed, _TEST_FINAL) == secret

    def test_round_trip_unicode_and_newlines(self) -> None:
        """Unicode, emoji and newlines survive the round-trip."""
        secret = "line one\nline two\ntab\there — 你好, 🌍"
        sealed = crypto.encrypt(secret, _TEST_FINAL)
        assert crypto.decrypt(sealed, _TEST_FINAL) == secret

    def test_wrong_key_fails(self) -> None:
        """Decrypting under a different puzzle hash fails."""
        sealed = crypto.encrypt("secret", _TEST_FINAL)
        with pytest.raises(IntegrityError):
            crypto.decrypt(sealed, b"\xbb" * 32)

    def test_encrypt_produces_nonce_and_tag(self) -> None:
        """Encrypted output carries a nonce and tag of expected sizes."""
        sealed = crypto.encrypt("x" * 100, _TEST_FINAL)
        assert len(sealed.nonce) == crypto.NONCE_LENGTH
        assert len(sealed.tag) == crypto.TAG_LENGTH
        assert len(sealed.hmac) == crypto.HMAC_LENGTH


class TestIntegrity:
    """Tampering detection."""

    def test_tampered_ciphertext_raises(self) -> None:
        """Flipping a ciphertext byte fails the HMAC integrity check."""
        sealed = crypto.encrypt("top secret", _TEST_FINAL)
        bad = crypto.EncryptedSecret(
            ciphertext=bytes([sealed.ciphertext[0] ^ 0xFF]) + sealed.ciphertext[1:],
            nonce=sealed.nonce,
            tag=sealed.tag,
            hmac=sealed.hmac,
        )
        with pytest.raises(IntegrityError):
            crypto.decrypt(bad, _TEST_FINAL)

    def test_tampered_nonce_raises(self) -> None:
        """Flipping a nonce byte fails the integrity check."""
        sealed = crypto.encrypt("top secret", _TEST_FINAL)
        bad = crypto.EncryptedSecret(
            ciphertext=sealed.ciphertext,
            nonce=bytes([sealed.nonce[0] ^ 0xFF]) + sealed.nonce[1:],
            tag=sealed.tag,
            hmac=sealed.hmac,
        )
        with pytest.raises(IntegrityError):
            crypto.decrypt(bad, _TEST_FINAL)

    def test_tampered_tag_raises(self) -> None:
        """Flipping a GCM tag byte fails authentication."""
        sealed = crypto.encrypt("top secret", _TEST_FINAL)
        bad = crypto.EncryptedSecret(
            ciphertext=sealed.ciphertext,
            nonce=sealed.nonce,
            tag=bytes([sealed.tag[0] ^ 0xFF]) + sealed.tag[1:],
            hmac=sealed.hmac,
        )
        with pytest.raises(IntegrityError):
            crypto.decrypt(bad, _TEST_FINAL)


class TestComputeHmac:
    """Tests for :func:`crypto.compute_hmac`."""

    def test_length(self) -> None:
        """The HMAC is 32 bytes."""
        assert len(crypto.compute_hmac(b"\x01" * 32, b"data")) == crypto.HMAC_LENGTH

    def test_deterministic(self) -> None:
        """Same key + data → same digest."""
        assert crypto.compute_hmac(b"\x01" * 32, b"x") == crypto.compute_hmac(
            b"\x01" * 32, b"x"
        )

    def test_data_sensitive(self) -> None:
        """Different data → different digest."""
        assert crypto.compute_hmac(b"\x01" * 32, b"x") != crypto.compute_hmac(
            b"\x01" * 32, b"y"
        )

    def test_key_sensitive(self) -> None:
        """Different key → different digest."""
        assert crypto.compute_hmac(b"\x01" * 32, b"x") != crypto.compute_hmac(
            b"\x02" * 32, b"x"
        )


class TestSecretValidation:
    """Secret size and content validation."""

    def test_empty_secret_rejected(self) -> None:
        """Empty secrets are invalid."""
        with pytest.raises(InvalidSecretError):
            crypto.encrypt("", _TEST_FINAL)

    def test_too_large_secret_rejected(self) -> None:
        """Secrets over MAX_SECRET_BYTES are invalid."""
        huge = "a" * (crypto.MAX_SECRET_BYTES + 1)
        with pytest.raises(InvalidSecretError):
            crypto.encrypt(huge, _TEST_FINAL)


class TestSecureWipe:
    """Tests for :func:`crypto.secure_wipe`."""

    def test_zeroes_data(self) -> None:
        """Contents are overwritten with zeros."""
        buf = bytearray(b"super secret bytes")
        crypto.secure_wipe(buf)
        assert all(b == 0 for b in buf)

    def test_empties_buffer(self) -> None:
        """Buffer length is reset to zero."""
        buf = bytearray(b"super secret bytes")
        crypto.secure_wipe(buf)
        assert len(buf) == 0