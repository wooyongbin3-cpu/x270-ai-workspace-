"""Exception hierarchy for Chronolock.

Every error raised by the library derives from :class:`ChronolockError` so
that callers (and the CLI) can catch a single base type, while still having
granular types for specific failure modes. The CLI maps these to friendly
messages and exit codes — see the ``handle_errors`` helper in
:mod:`chronolock.cli`.

Design notes:
    - Keep the hierarchy shallow and intent-revealing.
    - Each subclass should carry enough context to debug without leaking
      secrets (never embed plaintext secret material in an exception).
"""

from __future__ import annotations

from typing import List, Optional


class ChronolockError(Exception):
    """Base class for all Chronolock errors.

    Attributes:
        message: A human-readable description of the failure.
    """

    def __init__(self, message: str) -> None:
        super().__init__(message)
        self.message = message


class ConfigError(ChronolockError):
    """Raised when the CLI/store configuration is invalid or missing.

    Examples: an unknown vault directory, a malformed config value, or user
    input that cannot be interpreted (e.g. a bad ``--unlock-after`` value).
    """


class VaultNotFoundError(ChronolockError):
    """Raised when a referenced vault does not exist in the store.

    Attributes:
        vault_id: The identifier that could not be found. May be ``None`` if
            the lookup was attempted by name and no match was found.
    """

    def __init__(self, message: str, vault_id: Optional[str] = None) -> None:
        super().__init__(message)
        self.vault_id = vault_id


class VaultExistsError(ChronolockError):
    """Raised when creating a vault that would collide with an existing one.

    Happens when a ``name`` or ``vault_id`` is already present in the store.
    """


class CorruptVaultError(ChronolockError):
    """Raised when a vault file cannot be parsed as a valid vault container.

    Covers truncated files, invalid JSON, missing required fields, and any
    structural malformation. The file is *readable* but *not a valid vault*.
    """


class UnknownFormatError(CorruptVaultError):
    """Raised when a vault file has an unrecognised ``format`` or ``version``.

    This is a specialised :class:`CorruptVaultError` so that callers wanting
    to just treat anything malformed as "corrupt" can catch the base class.
    """


class IntegrityError(ChronolockError):
    """Raised when a vault's integrity check (HMAC) fails.

    This indicates the ciphertext was tampered with, corrupted in storage, or
    the binding between the vault's header and its payload was broken. The
    secret is deliberately **not** decrypted or surfaced in this case.
    """


class PuzzleError(ChronolockError):
    """Raised for any failure specific to the time-lock puzzle.

    Examples: an unsupported solver version, an invalid difficulty value, or
    a puzzle whose final chained state does not match the expected value
    recorded in the vault.
    """


class InvalidSecretError(ChronolockError):
    """Raised when the secret payload fails validation.

    This is used for blank secrets, secrets that exceed the max size, or
    secrets that do not match the entropy/format policy configured for the
    vault. The original value is never included in the message.
    """


class StoreIOError(ChronolockError):
    """Raised when an underlying filesystem operation fails.

    Wraps :class:`OSError` from file reads/writes into a Chronolock-specific
    exception so the CLI can present a consistent error surface. The original
    error is available via ``__cause__``.
    """

    def __init__(self, message: str, path: str, cause: BaseException) -> None:
        super().__init__(message)
        self.path = path
        self.__cause__ = cause


class MultiVaultError(ChronolockError):
    """Aggregates multiple per-vault errors during a bulk operation.

    Used by batch operations (e.g. ``chronolock list`` opening many vault
    headers) so one bad vault does not abort the whole run.

    Attributes:
        errors: List of ``(vault_id, error_message)`` tuples for each vault
            that failed.
    """

    def __init__(self, message: str, errors: List["tuple[str, str]"]) -> None:
        super().__init__(message)
        self.errors = errors