# Chronolock — Functional Specification

**Version:** 0.1.0 (draft for implementation)  
**Status:** Under development  
**Owner:** Chronolock maintainers

---

## 1. Overview

Chronolock is a command-line tool that lets a user bury a secret and have it
sealed until a chosen point in time — enforced not by a countdown timer but
by **cryptographic proof-of-work**. The lock is a sequential hash-chain puzzle:
to open a vault, a computer must perform a fixed, non-parallelisable number of
SHA-256 hash iterations. The cost of solving *is* the delay.

### 1.1 Elevator pitch

> "Bury a message. Bury it so deep that only time — measured in hashes — can
> dig it up. No server, no keyholder, no trust. Just math."

### 1.2 Success criteria

The tool is considered successful when:

1. A user can `bury` a secret with a chosen unlock time or difficulty.
2. The vault file can be copied anywhere; only the person/process that
   performs the required compute can open it.
3. Opening a vault is *physically* gated by the puzzle: there is no path that
   bypasses the sequential work.
4. Tampering with a vault file (flipping any byte of the payload, or the
   seed) causes opening to fail loudly.
5. The CLI is pleasant: clear summaries, a live progress bar, correct exit
   codes, and no secret leakage to stderr.

---

## 2. Terminology

| Term        | Meaning |
|-------------|---------|
| **Vault**   | A sealed container on disk (`*.vault` file) holding one encrypted secret plus its public metadata and puzzle parameters. |
| **Bury**    | The act of creating and sealing a vault. |
| **Open**    | The act of solving the vault's puzzle and decrypting its secret. |
| **Seed**    | A 32-byte random starting value for the hash chain. Public in the vault header; not secret. |
| **Difficulty** `d` | Number of sequential SHA-256 iterations in the puzzle. |
| **Puzzle solution** | The final chained hash `h_d`, from which the encryption key is derived. |
| **Hash rate** | Measured SHA-256 operations per second on this machine. |

---

## 3. User stories

| ID   | Story |
|------|-------|
| US-1 | As a user, I can bury a secret with a label, so I can recognise it later in listings. |
| US-2 | As a user, I can choose a target unlock time (`--unlock-after <unix-ts>`), so the difficulty is calibrated so opening takes roughly until then. |
| US-3 | As a user, I can instead choose a raw difficulty (`--difficulty N`), for explicit fine control. |
| US-4 | As a user, I can list vaults (`chronolock list`) to see names, statuses, and unlock times without solving anything. |
| US-5 | As a user, I can inspect a vault (`chronolock status <id>`) to see its public metadata. |
| US-6 | As a user, I can open a vault (`chronolock open <id>`) and watch a live progress bar. |
| US-7 | As a user, I can choose to print the revealed secret (`--reveal`); otherwise only the header and stats are shown. |
| US-8 | As a user, my secrets are never written anywhere in plaintext except stdout on explicit `--reveal`. |
| US-9 | As a user, tampered or corrupt vaults fail with clear, actionable errors. |
| US-10 | As a user, I can run all commands with `--dir` to point at a custom vault store (default: OS data dir). |

---

## 4. The time-lock puzzle (core requirement)

### 4.1 Construction

Given seed `S ∈ {0,1}^256` and difficulty `d ∈ [1, 2^32]`:

```
h_0   = SHA256(S)
h_i   = SHA256(h_{i-1})     for i = 1..d
```

Let `final = h_d`. This is the **puzzle solution**.

### 4.2 Properties (hard requirements)

- **Sequential** — each `h_i` depends on `h_{i-1}`; no parallelisation or
  vectorisation shortcut exists for plain SHA-256.
- **Deterministic** — `(S, d)` fully determines `final`.
- **Verifiable** — a solver can report progress `(done, total)` but cannot
  skip ahead.
- **Bounded** — `d` is validated to `[MIN_DIFFICULTY, MAX_DIFFICULTY]`.
- **Format versioned** — every vault records `solver_version = "puzzle-v1"`;
  unknown versions are rejected with `PuzzleError`.

### 4.3 Calibration

At bury time, if the user supplies a desired unlock time or duration, the CLI:

1. Measures this machine's hash rate (`measure_hash_rate`).
2. Computes `d = round(desired_seconds * hash_rate)`.
3. Clamps to bounds; returns an integer.

The estimate is shown to the user at bury time ("opening will take about
X on this machine"). Difficulty is a *compute* budget — not a wall-clock
promise across different hardware.

---

## 5. Cryptography

### 5.1 Key derivation

From `final` (the puzzle solution):

```
enc_key = HKDF-SHA256(ikm=final, salt=None, info="chronolock/v1/aes-256-gcm:enc", length=32)
mac_key = HKDF-SHA256(ikm=final, salt=None, info="chronolock/v1/aes-256-gcm:mac", length=32)
```

Same input → same keys (deterministic, required for reproducible unlock).
Encryption and MAC keys are always distinct.

### 5.2 Encryption

- **Algorithm:** AES-256-GCM (authenticated encryption).
- **Nonce:** 12 random bytes from `os.urandom`, fresh per encryption.
- **Format on disk (base64):** `nonce || ciphertext || tag`, with the
  additional `hmac` field described below.
- **Plaintext:** the secret's UTF-8 bytes. Maximum size
  `MAX_SECRET_BYTES = 256 KiB`. Empty secrets rejected.

### 5.3 Integrity

GCM provides authenticity of the ciphertext under the correct key. We add a
separate **HMAC-SHA256** over `nonce || ciphertext || tag`, keyed with
`mac_key`:

- Verifying `hmac` before attempting AES gives **fast corruption detection**
  (no expensive decrypt of garbage).
- The HMAC is compared in **constant time** (`hmac.compare_digest`).

### 5.4 Threat model (what this does and doesn't protect)

| Threat | Status | Notes |
|--------|--------|-------|
| Reading the ciphertext | ✗ Not secret | Ciphertext, nonce, tag, seed, difficulty, name, timestamps are all public file contents. |
| Guessing the secret offline | ✗ Out of scope | A weak secret is weak regardless of this tool; no password-based KDF is involved. |
| Tampering with the payload | ✓ Detected | HMAC fails → `IntegrityError`. |
| Tampering with the seed/header | ✓ Detected | Wrong seed → wrong key → GCM/HMAC failure. |
| Bypassing the work (reading code) | ✓ Prevented | The key simply does not exist until the chain is computed. |
| Parallelising the work | ✓ Prevented | Sequential hash chain. |
| Side-channel / memory forensics | ⚠️ Best-effort | `secure_wipe` zeroes buffers where practical; Python cannot guarantee memory erasure. |
| Mallicious vault-file generation ("free" bury) | ✓ Bounded | Burying incurs the same solve cost as opening (the creator also runs the chain once). |

---

## 6. Vault container format

File extension: `.vault`. Encoding: UTF-8 JSON, `base64` for all binary
fields. Versioned envelope (`format: "chronolock-vault"`, `version: 1`).

### 6.1 Canonical example

```json
{
  "format": "chronolock-vault",
  "version": 1,
  "seed": "AAECAwQFBgcICQ==",
  "difficulty": 100000,
  "solver_version": "puzzle-v1",
  "metadata": {
    "vault_id": "0f2c…(32 hex)",
    "name": "letter-to-graduation",
    "created_at": 1710000000,
    "unlock_after": 1741536000,
    "ciphertext_len": 24,
    "status": "locked"
  },
  "encrypted": {
    "ciphertext": "SGVsbG8gZnV0dXJlIQ==",
    "nonce": "1q2w3e4r5t6y",
    "tag": "u7v8w9x0y1z2a3b4",
    "hmac": "c4b2…(32 bytes)"
  },
  "meta": null
}
```

### 6.2 Field rules

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `format` | string | yes | Must equal `"chronolock-vault"` else `UnknownFormatError`. |
| `version` | int | yes | Must equal `1` else `UnknownFormatError`. |
| `seed` | string (base64) | yes | Decodes to exactly 32 bytes. |
| `difficulty` | int | yes | In `[MIN_DIFFICULTY, MAX_DIFFICULTY]`. |
| `solver_version` | string | yes | Must equal `"puzzle-v1"` else `PuzzleError` at open. |
| `metadata.*` | various | yes | Full `metadata` object required; missing → `CorruptVaultError`. |
| `encrypted.*` | strings (base64) | yes | `nonce` 12B, `tag` 16B, `hmac` 32B; ciphertext ≥ 1B. |
| `meta` | any JSON | no | Application metadata; never secrets. |

### 6.3 Write atomicity

- Serialize → write to `<final>.tmp.<pid>` in the same directory → `flush` +
  `fsync` → `os.replace` onto the final name.
- A crash mid-write can never leave a half-written `.vault`; temp files are
  cleaned on success.

---

## 7. Storage layer (VaultStore)

| Operation | Behaviour |
|-----------|-----------|
| `VaultStore(dir)` | Creates the directory if missing; raises `ConfigError` if path exists and is not a directory. `~` expanded; path absolutized. |
| `save(metadata, sealed)` | Atomically writes the container; raises `VaultExistsError` if the id already exists. |
| `load(id)` | Reads + validates + returns `LoadedVault(metadata, encrypted)`; raises `VaultNotFoundError` / `CorruptVaultError` / `UnknownFormatError` / `StoreIOError`. |
| `load_metadata(id)` | Header-only path; no base64 decode of payload. |
| `list_ids()` | Sorted ids of `*.vault` files (no parsing). |
| `list_metadata()` | All headers, newest-first; skips corrupt files (does **not** abort). |
| `default_store_path()` | `$CHRONOLOCK_DIR` → OS data dir → `<cwd>/.chronolock`. |

---

## 8. CLI specification

```
chronolock [--dir DIR] <command> [options]

Commands:
  bury   <name> <secret> [--unlock-after UNIXTS | --duration SECONDS]
         [--difficulty N]
  open   <vault_id> [--reveal]
  status <vault_id>
  list   [--verbose]
  --version, --help
```

### 8.1 Exit codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Operational error (vault missing, corrupt, integrity violation, puzzle failure, config error, unexpected). |
| 2 | Usage/argument error (argparse). |
| 130 | Interrupted (Ctrl-C). |

### 8.2 Output contract

- `bury`: prints a boxed summary (id, name, unlock date, difficulty,
  estimated wall-clock on this machine). **Never prints the secret.**
- `open`: prints header + stats (iterations, elapsed, rate). Prints the
  secret **only with `--reveal`**, to stdout.
- `status`: prints header only.
- `list`: aligned table of name / id-prefix / status / opens-in.
- All errors → stderr, prefixed by category (`config error: …`,
  `vault not found: …`, `corrupt vault: …`, `integrity check failed: …`,
  `puzzle error: …`, `unexpected error: …`).
- Colour enabled iff stdout is a TTY and `NO_COLOR` unset; `FORCE_COLOR`
  overrides.

### 8.3 Validation rules (bury)

- `name` non-empty; must be unique in the store.
- `secret` non-empty, ≤ `MAX_SECRET_BYTES` UTF-8 bytes.
- Exactly one of `--unlock-after`, `--duration`, `--difficulty` must be
  provided. Providing more than one → `ConfigError`.
- `--unlock-after` / `--duration` are positive ints.
- Flag combination `--unlock-after` + `--difficulty` is allowed (explicit
  difficulty overrides calibration), but `--duration` + `--difficulty`
  together → `ConfigError` (ambiguous).

---

## 9. Error taxonomy

| Exception | Raised when |
|-----------|-------------|
| `ConfigError` | Invalid CLI/config input (e.g. store dir is a file, conflicting flags). |
| `VaultNotFoundError` | Referenced id has no `.vault` file. |
| `VaultExistsError` | Save would overwrite an existing id. |
| `CorruptVaultError` | File parses but is structurally invalid (bad JSON, missing fields, bad base64, bad lengths). |
| `UnknownFormatError` (subclass of Corrupt) | `format`/`version` not recognised. |
| `IntegrityError` | HMAC mismatch — tampering or corruption of payload. |
| `PuzzleError` | Invalid difficulty, unsupported solver version, or puzzle evaluation failure. |
| `InvalidSecretError` | Empty or oversized secret. |
| `StoreIOError` | Underlying filesystem error (wraps `OSError`). |

---

## 10. Non-goals (out of scope for 0.1)

- Network/server mode, remote vault hosting, multi-user sharing.
- GUI / web dashboard (CLI only).
- Password- or passphrase-encrypted vaults (see §5.4).
- Timestamp authority / trusted third parties — the tool is trustless by design.
- Memory-hard puzzles (Argon2-style) — a *sequential* cost is desired, not
  a memory-hard one.
- Vault expiry/deletion policies.

---

## 11. Acceptance criteria

Each ticket references the tests that define its Done state. The global
definition of done:

- [ ] `make check` passes: lint (ruff) + typecheck (mypy) + full pytest suite.
- [ ] `pyproject.toml` packaging installs cleanly; `chronolock --version`
      prints `0.1.0`.
- [ ] **All tests in `tests/test_integration.py` pass** — the bury→open
      round-trip works end-to-end with real crypto and real disk I/O.
- [ ] Tampering tests prove detection (modified ciphertext/seed both fail).
- [ ] README reflects the implemented CLI with real usage examples.

---

## 12. Future ideas (roadmap)

See `docs/ROADMAP.md`. Short list: `--json` output mode, `destroy`
(secure-delete vault), `reseal` (change unlock time), multi-secret vaults,
and a `chronolock serve` polling mode.