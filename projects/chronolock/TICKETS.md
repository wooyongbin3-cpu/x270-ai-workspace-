# Chronolock — Sprint Backlog

This is your backlog. It mirrors how a real engineering team hands out work:
each ticket has a title, description, files-to-touch, priority, estimated
effort, and **acceptance criteria linked to concrete tests**.

Work tickets **in order** — they build on one another like real layered
features. Each ticket's "done" state is defined by tests that already exist
in this repository and are currently failing. Your job: make them pass by
implementing the `TODO(TICKET-00X)` markers in the linked modules.

```
Legend
  Prio   P0 = blocks everything / P1 = core feature / P2 = polish
  Size   S ≤0.5d · M 0.5–1d · L 1–2d · XL 2–3d  (estimates, not promises)
```

---

## Backlog

### TICKET-001 — Project scaffolding & dev environment ✅ *(already shipped)*
- **Status:** Done (pre-delivered)
- **Files:** `pyproject.toml`, `Makefile`, `tox.ini`, `requirements.txt`, `.gitignore`
- **What:** Packaging, quality gates (ruff/mypy/pytest), Makefile targets.
- **Acceptance criteria:**
  - [ ] `make dev-install` installs the package editable + dev deps.
  - [ ] `make help` lists all targets.
  - [ ] `make lint` / `make typecheck` / `make test` are runnable (even if tests fail — they're the spec).

---

### TICKET-002 — The hash-chain time-lock puzzle *(P0 · M)*
- **Files:** `src/chronolock/puzzle.py`
- **Tests:** `tests/test_puzzle.py`
- **What:** Implement `generate_seed`, `validate_difficulty`, `solve`, and
  `estimate_seconds` in `puzzle.py`. This is the mathematical heart of the
  whole product — the sequential SHA-256 chain.
- **Read first:** `puzzle.py` module docstring · `SPEC.md §4` · `ARCHITECTURE.md §3`.
- **Hints (not the answer):**
  - `solve` is a `for` loop with `hashlib.sha256(...).digest()`; validate
    difficulty and version first; call `progress` every ~1% of iterations.
  - `validate_difficulty` must reject non-ints *and* out-of-bounds values
    with `PuzzleError`.
  - `generate_seed` defaults to `os.urandom` (exactly 32 bytes); accepts an
    injectable source for tests.
  - `estimate_seconds` = `difficulty / hash_rate`, `ValueError` on non-positive rate.
- **Acceptance criteria:**
  - [ ] `pytest tests/test_puzzle.py -q` fully green.
  - [ ] `TestSolve.test_difficulty_1_returns_bytes` passes (32-byte hash).
  - [ ] `TestSolveProgress` passes (callbacks invoked, monotonic, final == total).
  - [ ] `TestValidateDifficulty` passes (bounds + type errors → `PuzzleError`).
  - [ ] `TestEstimateSeconds` passes.
- **When done:** Vaults can *compute* their cost; nothing can open yet without `crypto`.

---

### TICKET-003 — Encryption & integrity layer *(P0 · M)*
- **Files:** `src/chronolock/crypto.py`
- **Tests:** `tests/test_crypto.py`
- **What:** Implement `derive_keys`, `encrypt`, `decrypt`, `compute_hmac`,
  and `secure_wipe`. AES-256-GCM sealing, HKDF key derivation, HMAC integrity.
- **Read first:** `crypto.py` module docstring · `SPEC.md §5` · `ARCHITECTURE.md §4.2`.
- **Hints:**
  - Use `cryptography.hazmat.primitives.kdf.hkdf.HKDF` and
    `cryptography.hazmat.primitives.ciphers.aead.AESGCM`.
  - `derive_keys` returns `(enc_key, mac_key)` with distinct `info` labels.
  - `encrypt`: UTF-8 encode, validate size, fresh 12-byte nonce, HMAC over
    `nonce + ciphertext + tag` (keyed with `mac_key`).
  - `decrypt`: verify HMAC **first** (constant-time `hmac.compare_digest`),
    raise `IntegrityError` on mismatch; then AESGCM decrypt.
  - `secure_wipe`: zero-fill the `bytearray`, then `del data[:]`.
- **Acceptance criteria:**
  - [ ] `pytest tests/test_crypto.py -q` fully green.
  - [ ] Round-trips pass including unicode/emoji/multiline.
  - [ ] All three tamper tests raise `IntegrityError` (ciphertext, nonce, tag).
  - [ ] `derive_keys` determinism + `enc_key != mac_key`.
  - [ ] Empty/oversized secrets → `InvalidSecretError`.
- **When done:** Secrets can be sealed with a key derived from a puzzle
  solution — but nothing can persist them yet.

---

### TICKET-004 — Vault store & container format *(P0 · M)*
- **Files:** `src/chronolock/store.py`
- **Tests:** `tests/test_store.py`
- **What:** Implement `VaultStore` (init/save/load/load_metadata/list_ids/
  list_metadata), `default_store_path`, `generate_vault_id`, `_validate_metadata`.
- **Read first:** `store.py` module docstring (container format) · `SPEC.md §6–7`.
- **Hints:**
  - JSON envelope, base64 for binary fields. Write temp file + `os.replace` (atomic).
  - `save`: raise `VaultExistsError` if the id file already exists.
  - `load`: validate `format`/`version` (→ `UnknownFormatError`), decode
    base64 (→ `CorruptVaultError`), check lengths.
  - `list_metadata`: newest-first by `created_at`; **skip** corrupt files.
  - `default_store_path`: `$CHRONOLOCK_DIR` → platform dir → `<cwd>/.chronolock`.
- **Acceptance criteria:**
  - [ ] `pytest tests/test_store.py -q` fully green.
  - [ ] Save→load round-trips are byte-identical.
  - [ ] Corrupt/unknown-format files raise the right typed errors.
  - [ ] No `*.tmp` files remain after save (atomicity).
  - [ ] `list_metadata` skips corrupt vaults without aborting.
- **When done:** Vaults live on disk, but nothing orchestrates them yet.

---

### TICKET-005 — Orchestration: bury / open / inspect / list *(P0 · L)*
- **Files:** `src/chronolock/vault.py`
- **Tests:** `tests/test_integration.py` (the capstone!) · `tests/conftest.py`
- **What:** Implement `bury`, `open_vault`, `inspect`, `list_vaults`,
  `vault_status`. Wire `puzzle` + `crypto` + `store` together.
- **Read first:** `vault.py` module docstring · `ARCHITECTURE.md §3` (the data-flow diagrams).
- **Hints:**
  - `bury`: validate → calibrate → seed → `puzzle.solve` → `crypto.encrypt` →
    build `VaultMetadata` → `store.save`. Return `Vault(metadata, secret)`
    with the plaintext **only in memory**.
  - `open_vault`: `store.load` → build spec from stored seed/difficulty →
    `puzzle.solve` → `crypto.decrypt`. Time it for `UnlockResult`.
  - Use `difficulty.seconds_to_difficulty` / `measure_hash_rate` when
    calibrating from `unlock_after`, and the vault's `difficulty` when the
    user passed one explicitly. (Validate both inputs even when explicit.)
- **Acceptance criteria (THE definition of done):**
  - [ ] **`pytest tests/test_integration.py -q` fully green.**
  - [ ] Bury persists a vault file; open recovers the exact secret.
  - [ ] Tampered ciphertext and tampered seed both fail to open.
  - [ ] `iterations`, `elapsed_seconds`, `rate` are reported correctly.
  - [ ] `inspect`/`list_vaults` work without solving anything.
- **When done:** **The product works.** You can bury a secret and open it.

---

### TICKET-006 — Difficulty calibration *(P1 · S)*
- **Files:** `src/chronolock/difficulty.py`
- **Tests:** `tests/test_difficulty.py`
- **What:** Implement `measure_hash_rate`, `seconds_to_difficulty`,
  `format_estimate`. Turns "I want it to open in ~a week" into a difficulty.
- **Read first:** `difficulty.py` module docstring · `SPEC.md §4.3`.
- **Hints:**
  - `measure_hash_rate`: warm-up ~10k hashes, then time `samples`; cache result.
  - `seconds_to_difficulty`: `round(seconds * rate)`, clamp to puzzle bounds,
    optionally snap. `ValueError` on non-positive `desired_seconds`.
  - `format_estimate`: decompose seconds into d/h/m/s with correct plurals
    ("1 day" vs "2 days"). Match the parametrized cases exactly.
- **Acceptance criteria:**
  - [ ] `pytest tests/test_difficulty.py -q` fully green.
  - [ ] `TestFormatEstimate` passes all 11 parametrized cases.
  - [ ] Clamping to `MIN_DIFFICULTY`/`MAX_DIFFICULTY` verified.
  - [ ] Hash-rate caching: second call doesn't re-benchmark.
- **When done:** Users can bury by wall-clock target instead of raw difficulty.

---

### TICKET-007 — Terminal UI rendering *(P2 · M)*
- **Files:** `src/chronolock/ui.py`
- **Tests:** add unit tests in `tests/test_ui.py` (or verify via manual CLI run
  after TICKET-008)
- **What:** Implement `enable_colour`, `render_bury_summary`,
  `render_progress_bar`, `render_header`, `render_list`, `_format_duration`.
- **Read first:** `ui.py` module docstring · `SPEC.md §8.2` (output contract).
- **Hints:**
  - `enable_colour`: honour `NO_COLOR` / `FORCE_COLOR`; fall back to `isatty`.
  - `render_progress_bar`: `"█"*filled + "░"*(width-filled)` + percent.
  - `_format_duration`: delegate to `difficulty.format_estimate`.
  - The render functions are **pure** — data in, string out. No printing.
- **Acceptance criteria:**
  - [ ] `render_progress_bar` output matches e.g. `"████▓░░░░░ 32%"` shape.
  - [ ] `render_bury_summary` contains id, name, unlock date, difficulty.
  - [ ] `render_list` renders a table with a status column.
  - [ ] No function writes to stdout/stderr.
- **When done:** The CLI has a presentable face.

---

### TICKET-008 — CLI wiring & error mapping *(P1 · M)*
- **Files:** `src/chronolock/cli.py`
- **Tests:** `tests/test_cli.py`
- **What:** Implement `cmd_bury`, `cmd_open`, `cmd_status`, `cmd_list`,
  `_build_store`, `_handle_errors`.
- **Read first:** `cli.py` module docstring · `SPEC.md §8`.
- **Hints:**
  - `cmd_bury`: build `BuryOptions`; reject conflicting flags
    (`--unlock-after` + `--duration`, or `--duration` + `--difficulty`) with
    `ConfigError`; render the summary via `ui.render_bury_summary`.
  - `cmd_open`: render header + stats; reveal secret **only** with `--reveal`.
  - `_handle_errors`: map each `ChronolockError` subclass to a prefixed stderr
    message; exit code `1`; unexpected → `1` with repr; write via `sys.stderr`.
- **Acceptance criteria:**
  - [ ] `pytest tests/test_cli.py -q` fully green.
  - [ ] `main(["--version"])` exits 0 and prints the version.
  - [ ] `_handle_errors` produces prefixed messages ("config error: …",
        "vault not found: …", "integrity check failed: …", etc.).
  - [ ] Manual check: `chronolock bury demo "hello" --difficulty 1000 --dir /tmp/v`
        shows a boxed summary; `chronolock list --dir /tmp/v` lists it.
- **When done:** **`make check` is fully green. The MVP is shippable.**

---

## Sprint summary (what all of this adds up to)

> ✅ **All tickets below are done** — `make check` is green.

| Ticket | Area | Prio | Size | Tests to turn green |
|--------|------|------|------|---------------------|
| 001 | Scaffolding | — | — | — (shipped) |
| 002 | Puzzle | P0 | M | `test_puzzle.py` |
| 003 | Crypto | P0 | M | `test_crypto.py` |
| 004 | Store | P0 | M | `test_store.py` |
| 005 | Orchestration | P0 | L | `test_integration.py` ⭐ |
| 006 | Calibration | P1 | S | `test_difficulty.py` |
| 007 | UI | P2 | M | manual / `test_ui.py` |
| 008 | CLI | P1 | M | `test_cli.py` |

**Capstone:** when 002–005 are done, `tests/test_integration.py` goes green —
that's the moment Chronolock actually works. Tickets 006–008 make it a joy
to use.

---

## After the MVP

See `docs/ROADMAP.md` for 0.2.0+ ideas (`destroy`, `--json`, `reseal`, …).
New tickets for those should follow the same format so the backlog stays
consistent.