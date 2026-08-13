# 🔒 Chronolock

**Bury a secret. Time is the key. Math is the lock.**

Chronolock is a command-line tool that seals a secret until a chosen moment in
the future — enforced **not by a countdown timer but by cryptographic
proof-of-work**. To open a vault you must literally perform a fixed number of
sequential SHA-256 hash operations. No shortcut. No parallelisation. No
trusted server. Just computation.

```
$ chronolock bury graduation-letter "The answer is 42" --difficulty 1000000
┌──────────────────────────────────────────────────────────┐
│                    Secret buried 🔐                      │
├──────────────────────────────────────────────────────────┤
│  Vault ID      b64c2f...e91d                            │
│  Name          graduation-letter                        │
│  Opens after   ~5 minutes on this machine               │
│  Difficulty    1,000,000 hash iterations                │
└──────────────────────────────────────────────────────────┘
```

---

## Why this is cool

Chronolock implements the classic **Rivest–Shamir–Wagner time-lock puzzle**
idea as a pure proof-of-work hash chain:

```
h_0 = SHA256(seed)
h_i = SHA256(h_{i-1})     ← every step depends on the last
```

Because each hash depends on the previous one, the work is **inherently
sequential** — throwing a thousand GPUs at a vault is no faster than one CPU.
The encryption key simply doesn't exist until the chain has been fully
computed. That's the whole trick, and it makes for a genuinely interesting
thing to build, demo, and explain.

### What you can do with it

- Draft a letter to your future self, sealed by real compute.
- Hand over a password in advance that *cannot* be read before its time.
- Prove you thought of a secret before a deadline (the vault is tamper-evident).
- Demo a real cryptographic tool with a live progress bar and honest math.

---

## Status

| | |
|---|---|
| MVP implementation | 🚧 In progress — see [`TICKETS.md`](TICKETS.md) |
| Spec | ✅ [`SPEC.md`](SPEC.md) |
| Architecture | ✅ [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) |
| Roadmap | ✅ [`docs/ROADMAP.md`](docs/ROADMAP.md) |
| Test suite | ✅ Written (the definition of done) — deliberately red until the tickets are implemented |

This repo is structured like a real engineering hand-off: **everything but the
implementation**. The tests, spec, architecture, and ticket backlog are all
in place; the `# TODO(TICKET-00X)` markers in `src/chronolock/` are your job.
See [`AGENTS.md`](AGENTS.md) — it's your onboarding guide.

---

## Install

```bash
cd chronolock
python -m venv .venv && source .venv/bin/activate
make dev-install        # pip install -e ".[dev]"
```

Requires **Python 3.9+**. Runtime dependency: [`cryptography`](https://pypi.org/project/cryptography/).

---

## Usage

```bash
# Bury a secret with an explicit difficulty (hash iterations)
chronolock bury myvault "top secret" --difficulty 1000000

# Bury with a target unlock time (calibrates difficulty for this machine)
chronolock bury will "I knew it all along" --unlock-after 1750000000

# Bury by duration (the opening will take about this long on this machine)
chronolock bury note "hello future" --duration 86400

# List vaults (no puzzle solving — cheap)
chronolock list

# Inspect one vault
chronolock status <vault_id>

# Open a vault (this is the slow part — that's the point)
chronolock open <vault_id>

# Open and print the secret
chronolock open <vault_id> --reveal

# Point everything at a custom store
chronolock --dir ~/my-vaults list
```

### Demo it live

```bash
chronolock bury demo "If you're reading this, the hashes have been hashed." \
  --difficulty 200000          # a few seconds of work
chronolock open <vault_id>     # watch the progress bar
chronolock open <vault_id> --reveal
```

---

## How it works (the 30-second version)

1. **Bury:** a random seed is generated, and the hash chain is run once to
   derive an encryption key. The secret is sealed with **AES-256-GCM** and
   the encrypted payload, seed, and difficulty are written to a
   human-inspectable JSON vault file.
2. **Open:** the chain is re-run from the recorded seed — one hash at a time —
   until the final hash is reached. Only then can the key be derived and the
   secret decrypted. The **work is the delay**.
3. **Tamper-evidence:** an **HMAC-SHA256** binds the payload together; flip
   any byte of ciphertext, nonce, or tag, and opening fails loudly.

For the full design: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) and
[`SPEC.md`](SPEC.md).

---

## Project layout

```
chronolock/
├── SPEC.md               # functional requirements · threat model · container format
├── AGENTS.md             # onboarding & engineering workflow
├── CONTRIBUTING.md       # review process & conventions
├── TICKETS.md            # the sprint backlog (your to-do list)
├── docs/
│   ├── ARCHITECTURE.md   # layers · data flow · design rationale
│   └── ROADMAP.md        # where it's going
├── src/chronolock/       # the package (implementation is YOUR job)
│   ├── puzzle.py         # hash-chain time-lock puzzle
│   ├── crypto.py         # AES-256-GCM · HKDF · HMAC
│   ├── store.py          # vault container format · atomic IO
│   ├── vault.py          # orchestration: bury / open / inspect / list
│   ├── difficulty.py     # calibration · hash-rate measurement
│   ├── ui.py             # terminal rendering
│   └── cli.py            # CLI entry point & error mapping
└── tests/                # the spec as code — deliberately failing until implemented
    └── test_integration.py   # ⭐ the end-to-end definition of done
```

---

## Development

```bash
make test          # run the whole suite
make test -m pytest tests/test_puzzle.py -q   # targeted (see TICKETS.md)
make lint          # ruff
make typecheck     # mypy
make check         # all three gates
```

The test suite is the **contract**. It is written and complete — your job on
each ticket is to make it pass without modifying it. See `TICKETS.md` for the
work order (start at **TICKET-002**).

---

## License

MIT — see [LICENSE](LICENSE) *(add it before first release)*.

---

## Acknowledgements

- The time-lock puzzle concept: **Rivest, Shamir & Wagner (1996)**,
  *"Time-lock puzzles and timed-release crypto"* — our construction is a
  simplified, pure proof-of-work instantiation.
- Built with the [`cryptography`](https://pypi.org/project/cryptography/)
  library's excellent high-level primitives.

---

<p align="center"><em>Bury something worth waiting for.</em></p>