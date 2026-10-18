# Chronolock — Architecture & Design

This document describes the system design: module responsibilities, data
flow, the layered architecture, and the reasoning behind key decisions. It is
intended for anyone (including your future self, in interviews) to be able to
explain *how* Chronolock works and *why* it is built this way.

---

## 1. Layered architecture

Chronolock is a strict **layered** library. Dependencies flow downward only;
no higher layer is ever imported by a lower one.

```
┌──────────────────────────────────────────────────────────────┐
│                      CLI (cli.py + ui.py)                     │
│   argparse · rendering · error→exit-code · progress display  │
└───────────────────────────────┬──────────────────────────────┘
                                │ composes
┌───────────────────────────────▼──────────────────────────────┐
│                 Orchestration (vault.py)                      │
│   bury · open_vault · inspect · list_vaults · vault_status    │
└──────────────┬───────────────────────────────┬───────────────┘
               │                               │
┌──────────────▼────────────┐     ┌────────────▼───────────────┐
│      Puzzle (puzzle.py)   │     │     Crypto (crypto.py)     │
│  hash-chain solver        │     │  HKDF · AES-GCM · HMAC     │
│  difficulty validation    │     │  size validation · wipe    │
└──────────────┬────────────┘     └────────────┬───────────────┘
               │ feeds the key into            │
               └────────────────────────────────┘
                               │ both produce/consume
┌──────────────────────────────▼──────────────────────────────┐
│              Persistence (store.py)                          │
│  container format · atomic IO · store dir · id generation    │
└──────────────────────────────┬──────────────────────────────┘
                               │ imports only
┌──────────────────────────────▼──────────────────────────────┐
│              Support (model.py · errors.py)                  │
│   dataclasses & value objects · exception hierarchy          │
└──────────────────────────────────────────────────────────────┘
```

### 1.1 Dependency rules

- `cli.py` may import `vault`, `store`, `difficulty`, `ui`, `errors`.
- `vault.py` may import `puzzle`, `crypto`, `store`, `model`, `errors`.
- `store.py` may import `crypto` (for `EncryptedSecret` typing & `compute_hmac`),
  `model`, `errors`.
- `puzzle.py` / `crypto.py` import only `model`-adjacent types + stdlib.
- `ui.py` imports `model` only (pure rendering).
- **Never**: `store` imports `vault`; `puzzle` imports `crypto`; any module
  imports `ui`.

Violating these rules is a design smell and a code-review blocker.

---

## 2. Module responsibilities

| Module | Responsibility | Key public API |
|--------|----------------|----------------|
| `model.py` | Pure data: statuses, metadata, vault, unlock result | `VaultStatus`, `VaultMetadata`, `Vault`, `UnlockResult` |
| `errors.py` | Exception hierarchy (single base `ChronolockError`) | `ChronolockError` + subclasses |
| `puzzle.py` | Time-lock primitive: sequential SHA-256 chain | `PuzzleSpec`, `generate_seed`, `solve`, `validate_difficulty`, `estimate_seconds` |
| `crypto.py` | Key derivation, sealing, verification, wiping | `derive_keys`, `encrypt`, `decrypt`, `compute_hmac`, `secure_wipe` |
| `store.py` | On-disk vault container + atomic IO + store dir | `VaultStore`, `LoadedVault`, `default_store_path`, `generate_vault_id` |
| `vault.py` | Orchestration of bury/open/status/list | `bury`, `open_vault`, `inspect`, `list_vaults`, `vault_status` |
| `difficulty.py` | Hash-rate measurement & duration→difficulty | `measure_hash_rate`, `seconds_to_difficulty`, `format_estimate` |
| `ui.py` | Terminal rendering (ANSI, progress, tables) | `enable_colour`, `render_*`, `_banner` |
| `cli.py` | Composition root: args, dispatch, error mapping | `build_parser`, `main`, `cmd_*` |

---

## 3. Core data flow

### 3.1 `bury` (create a vault)

```
user → cli.cmd_bury
     → vault.bury(store, options, progress)
         │ 1. validate options
         │ 2. difficulty = explicit ? explicit : seconds_to_difficulty(desired, hash_rate)
         │ 3. seed = puzzle.generate_seed()                  (CSPRNG)
         │ 4. solution = puzzle.solve(PuzzleSpec(seed, d))   (runs the chain once)
         │ 5. sealed = crypto.encrypt(secret, solution.final_hash)
         │ 6. metadata = VaultMetadata(...)
         │ 7. store.save(metadata, sealed)                   (atomic JSON write)
         └─ returns Vault(metadata, secret)   ← plaintext only in memory
→ cli prints render_bury_summary(...)          ← never the secret
```

### 3.2 `open` (unlock a vault)

```
user → cli.cmd_open
     → vault.open_vault(store, id, progress)
         │ 1. loaded = store.load(id)             (metadata + encrypted)
         │ 2. spec = PuzzleSpec(seed, difficulty)
         │ 3. solution = puzzle.solve(spec, progress)   ← 🔥 THE DELAY 🔥
         │ 4. plaintext = crypto.decrypt(loaded.encrypted, solution.final_hash)
         └─ returns UnlockResult(vault, iterations, elapsed)
→ cli prints header + stats; secret only if --reveal
```

**The essential insight:** step 3 *is* the lock. The key simply does not
exist until the chain has been fully re-computed. There is nothing to steal,
no flag to flip — only math stands between you and the secret.

---

## 4. Why these design choices?

### 4.1 Why a hash chain (not a timer)?

A timer is a *suggestion*; it lives in software an attacker can edit, or on a
clock an attacker can change. A hash chain is a physical fact: you either
computed the iterations or you didn't. This is the same class of construction
as the classic **Rivest–Shamir–Wagner (1996) time-lock puzzle**, applied to a
pure proof-of-work chain. (Our chain is intentionally simpler than RSW's
modular-exponentiation construction — it trades memory/space for the clean,
inspectable property that every hash is required. The trade-off: no algebraic
shortcut exists for SHA-256, whereas RSA-modular-exponent puzzles *do* have a
theoretical shortcut for the puzzle designer. For our threat model — no trusted
setup — the hash chain is the honest choice.)

### 4.2 Why AES-256-GCM + HKDF + HMAC?

- **HKDF** turns the 256-bit puzzle output into two independent, labelled
  keys. Deterministic by construction (same `final` → same keys).
- **AES-GCM** is authenticated encryption: it both encrypts *and* detects
  tampering in one primitive.
- **HMAC-SHA256** (on `nonce||ciphertext||tag`) gives us a *cheap* fast-fail
  integrity check before we spend the cost of an AES decrypt — and because the
  MAC key is derived from the puzzle, a wrong seed fails here too, without
  needing the decrypt to round-trip.

### 4.3 Why JSON + base64 on disk?

- Human-inspectable (you can `cat` a vault and see exactly what is public).
- Trivially versionable (`format` + `version` envelope).
- Zero dependencies beyond stdlib `json`/`base64`.
- Base64 overhead (~33%) is irrelevant for ≤256 KiB secrets.

### 4.4 Why atomic writes?

A crashed `save` must never leave a truncated `.vault`. Temp-then-`os.replace`
guarantees the final path is either the old complete file or the new complete
file — never a half-written one.

### 4.5 Why is `ui.py` separated from `cli.py`?

Testability and rigour. All the pretty formatting lives in pure functions in
`ui.py` that take data and return strings — unit-testable without a terminal
or a subprocess. `cli.py` stays thin: parse args, call the library, render,
map errors.

### 4.6 Why `py.typed` / type-annotated throughout?

`pyproject.toml` sets `disallow_untyped_defs = true` for mypy. Every public
function is annotated. This is a self-imposed standard — it makes the codebase
readable, self-documenting and interview-safe, and `make typecheck` becomes a
hard gate.

---

## 5. Concurrency and threading

- `puzzle.solve` is **synchronous and blocking** by design; there is no value
  in a background thread because the work is sequential.
- Progress is reported via **callbacks**, not by peeking at a running thread.
  The CLI renders a progress bar by redrawing on each callback.
- The vault store has **no locking**; the contract is single-writer per
  process. (Multi-process access is a future `ROADMAP` item.)
- `measure_hash_rate` caches its result in a module variable (machines don't
  change speed mid-process); it is not thread-safe but the CLI is single-
  threaded.

---

## 6. Error-handling strategy

- Every library layer raises typed exceptions from `errors.py` (single base
  `ChronolockError`).
- `cli.main` wraps dispatch in a `try/except ChronolockError` and funnels
  through `_handle_errors`, which maps type → friendly stderr message + exit
  code.
- `store.list_metadata` deliberately **swallows** per-vault parse errors
  (skips corrupt vaults) rather than aborting a listing — the batch operation
  never thrashes the whole list because one file is bad. (A `--verbose` mode
  surfaces them.)

---

## 7. Storage layout

Default store locations (see `store.default_store_path`):

| OS | Path |
|----|------|
| Linux | `~/.local/share/chronolock/` |
| macOS | `~/Library/Application Support/chronolock/` |
| Windows | `%APPDATA%\chronolock\` |
| Override | `$CHRONOLOCK_DIR` or `--dir <path>` |

Inside a store, each vault is one file: `<vault_id>.vault`.

---

## 8. Testing strategy

Two tiers, enforced by pytest markers (`--strict-markers`):

| Tier | Marker | Scope | Examples |
|------|--------|-------|----------|
| Unit | `@pytest.mark.unit` (default) | A single module, no real IO | `derive_keys` determinism, `solve` determinism, `format_estimate` |
| Integration | `@pytest.mark.integration` | Full stack, real crypto + disk | `tests/test_integration.py`: bury→open round-trip, tampering detection |

Fixtures are centralized in `tests/conftest.py`:
- `vault_store` → fresh temp dir per test.
- `entropy_source` / `tiny_puzzle_spec` → deterministic, fast puzzle inputs.
- `sample_metadata`, `sealed_secret` → valid data objects independent of unimplemented code.

The integration tests are your **definition of done** — when they pass, the
tool genuinely works.

---

## 9. Extending the format (forward compatibility)

If you ever need a breaking change to the container:

1. Bump `FORMAT_VERSION` to `2`.
2. Keep `version: 1` **read** support (load both).
3. Add a migration path in `store.load` (or a `vault migrate` command).
4. Never silently rewrite an old vault.

Keeping old-format reads working is a hard requirement; silently changing the
format would orphan every existing vault.

---

## 10. Glossary

See `SPEC.md §2`. Additionally:

- **HKDF** — HMAC-based key derivation function (RFC 5869).
- **AES-GCM** — Galois/Counter Mode; authenticated encryption.
- **RSW time-lock** — Rivest, Shamir & Wagner's 1996 time-lock puzzle
  construction using modular squaring.