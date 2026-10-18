# Chronolock — Roadmap

Where the project has been, where it's going, and what's on the horizon.

---

## Current milestone: MVP (0.1.0) — the time-locked vault

The entire repository as it stands is the scaffold for this milestone. All
implementation work is tracked in `TICKETS.md` (TICKET-001 → TICKET-008).

### Core feature set (in scope for 0.1.0)

- [x] Project scaffolding, packaging, quality gates (`pyproject.toml`, `Makefile`, `tox.ini`)
- [x] Layered architecture with strict dependency rules
- [x] Full unit + integration test suite (the definition of done)
- [x] Full functional spec + architecture documentation
- [ ] **TICKET-002** — the hash-chain time-lock puzzle (`puzzle.py`)
- [ ] **TICKET-003** — AES-GCM encryption + HMAC integrity (`crypto.py`)
- [ ] **TICKET-004** — vault container format + store (`store.py`)
- [ ] **TICKET-005** — orchestration: bury / open / inspect / list (`vault.py`)
- [ ] **TICKET-006** — difficulty calibration (`difficulty.py`)
- [ ] **TICKET-007** — terminal UI rendering (`ui.py`)
- [ ] **TICKET-008** — CLI wiring + error mapping (`cli.py`)

**Exit criteria for 0.1.0:** `make check` green; integration tests pass;
`chronolock bury` / `open` / `status` / `list` all work end-to-end.

---

## Near-term (0.2.0)

| Feature | Description | Motivation |
|---------|-------------|------------|
| `destroy` command | Securely wipe a vault file (overwrite + delete). | Users will want to remove a pre-opened secret properly. |
| `--json` output | Machine-readable output for `list`/`status`. | Scriptability; makes the tool pipeline-friendly. |
| `reseal` | Open an unlocked vault and re-bury it with a new unlock time / difficulty. | A natural lifecycle: "extend" or "shorten" a vault. |
| Progress ETA in the solver | Show remaining-time estimate in the progress bar. | Better UX for very long puzzles. |
| Multi-process store locking | File lock so two processes can't corrupt the store. | Correctness as usage grows. |

---

## Later (1.0.0+)

| Feature | Description | Notes |
|---------|-------------|-------|
| Multi-secret vaults | One vault, many sealed fields, one puzzle. | Sized payloads; addresses "I want to bury 5 things". |
| `chronolock serve` | A long-running poller that opens vaults when time is up and hands them to an output (file, webhook). | The "capillary" / automation use case. |
| Password factor | *Optional* additional passphrase layered over the puzzle. | Changes the threat model; must be opt-in, documented, and carefully specified. |
| `checkup` / health | Validate every vault in a store and report corrupt ones. | Ops-friendly. |
| Backup/export format | A single-file bundle of all vaults + integrity manifest. | Moving the whole store is currently copy-the-directory; a bundle is tidier. |

---

## Explicitly non-goals (won't do)

- Server-hosted vaults / accounts / billing — this is a local, trustless tool.
- GUI — the terminal is the interface.
- Blockchain / NFT tie-ins — the proof-of-work is *local*, not a ledger.
- Replacing a password manager — different threat model (see `SPEC.md §5.4`).

---

## How to contribute along the roadmap

1. Work the tickets in `TICKETS.md` order — they build on each other.
2. Each ticket must meet its acceptance criteria (the linked tests) and the
   global Definition of Done in `SPEC.md §11`.
3. Open a PR with a reference to the ticket (`Closes TICKET-00X`).

---

## Note for maintainers

The roadmap is intentionally small and focused. The magic of Chronolock is its
simplicity: one trick (time as work) done properly. Resist scope creep — a
sharp tool beats a Swiss-army knife here.