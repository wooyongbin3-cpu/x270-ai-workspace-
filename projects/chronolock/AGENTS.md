# AGENTS.md — Engineering Onboarding & Workflow Guide

**Welcome to the Chronolock squad.** 🎉

This is *your* project now. It's a real, production-shaped codebase laid out
exactly how a team would hand a feature to you on day one: a full spec, an
architecture, a test suite, and a ticket backlog. Everything is in place
**except the implementation**. Your job is to build it, ticket by ticket,
exactly as you'd operate in a real engineering team.

Read this whole file before you write a single line of code.

---

## 1. What Chronolock is (30-second version)

Chronolock is a CLI that buries a secret behind a **cryptographic time-lock**:
a sequential hash-chain puzzle. To open a vault you must *literally perform*
`difficulty` SHA-256 hashes in order. No shortcut, no parallelisation. The
delay is enforced by mathematics, not by a timer you could cheat.

- `SPEC.md` — the *what* (functional requirements, threat model, container format)
- `docs/ARCHITECTURE.md` — the *how* (layers, data flow, design rationale)
- `docs/ROADMAP.md` — where it's going
- `TICKETS.md` — the work, split into tickets with acceptance criteria

---

## 2. How this repo is structured

```
chronolock/
├── pyproject.toml        # packaging + tool config (pytest, mypy, ruff)
├── Makefile              # dev workflow: make test / lint / typecheck / check
├── tox.ini               # multi-env quality matrix
├── requirements.txt      # runtime + dev deps
├── SPEC.md               # functional specification
├── AGENTS.md             # you are here
├── CONTRIBUTING.md       # contribution & review process
├── TICKETS.md            # the backlog
├── docs/
│   ├── ARCHITECTURE.md
│   └── ROADMAP.md
├── src/chronolock/       # the package
│   ├── __init__.py   model.py   errors.py
│   ├── puzzle.py     crypto.py  store.py
│   ├── vault.py      difficulty.py  ui.py  cli.py
└── tests/
    ├── conftest.py
    ├── test_puzzle.py  test_crypto.py  test_store.py
    ├── test_difficulty.py  test_cli.py
    └── test_integration.py   ← the capstone "definition of done"
```

---

## 3. Your first commands

```bash
cd chronolock

# One-time setup
python -m venv .venv && source .venv/bin/activate
make dev-install            # pip install -e ".[dev]"

# Your workflow loop
make test                   # run the whole suite (expect failures — they're your spec)
make lint                   # ruff
make typecheck              # mypy
make check                  # all three at once
```

> A note on the failing tests: **that is by design.** The test suite is your
> contract with the spec. Your job is to make them pass by implementing the
> `# TODO(TICKET-00X):` markers in `src/chronolock/*.py`. Do not edit tests to
> make them pass — edit the code. (If you genuinely believe a test is wrong,
> that's a design conversation, not a silent change.)

---

## 4. The working agreement (how the team operates)

### 4.1 Ticket workflow (mirrors a real sprint)

1. **Pick up a ticket** from `TICKETS.md` (work in order; they build on each
   other). Optionally open it as a GitHub issue using the templates in
   the repository root `.github/ISSUE_TEMPLATE/` (`chronolock-*.md`).
2. **Create a feature branch** named `ticket/00X-short-slug`.
3. **Implement** the `TODO` markers in the linked module(s).
4. **Run the ticket's tests** — they must all pass. Then run the *whole* suite
   to catch regressions.
5. **Run `make check`** (lint + typecheck + tests). Must be green.
6. **Commit** with a message linking the ticket:
   `Closes TICKET-002: implement the hash-chain puzzle`.
7. **Open a PR** (if you're pushing to GitHub) — see `CONTRIBUTING.md`.

### 4.2 Definition of done (DoD) — every ticket must hit ALL of:

- [ ] `make check` passes with your changes.
- [ ] The ticket's linked tests pass (see the ticket's acceptance criteria).
- [ ] No new `NotImplementedError` in the module(s) you touched.
- [ ] No secrets/logging of secrets introduced.
- [ ] New public functions are type-annotated and docstringed.
- [ ] You can explain *why* — you'll be asked in review.

### 4.3 Things to never do

- ❌ Edit `tests/` to force a pass. The tests are the spec.
- ❌ Change the documented public API without a ticket.
- ❌ `print()` secrets to stdout/stderr (use the `ui` layer + `--reveal`).
- ❌ Break the layering (see `ARCHITECTURE.md §1.1`).
- ❌ Leave a `raise NotImplementedError` in a module you claimed done.

---

## 5. The layering you must respect

```
cli.py ➜ vault.py ➜ { puzzle.py, crypto.py, store.py } ➜ model.py/errors.py
              \       ui.py (rendering only)
```

- Lower layers never import higher layers.
- `ui.py` only imports `model` — it renders data, it never solves puzzles.
- `store.py` never knows about `vault.py`.
- Keep it that way. A review will reject violations.

---

## 6. Testing conventions

- Unit tests = one module, no real IO. Marked `@pytest.mark.unit` (implicit
  when not marked; `--strict-markers` is on).
- Integration tests = full stack, real crypto + disk (`tests/test_integration.py`).
- Run targeted: `pytest tests/test_puzzle.py -q` or
  `pytest -m integration`.
- The integration suite is **the** signal that you're done.

---

## 7. What "done" looks like for the whole MVP

When all of these are true, the MVP is shippable:

- [ ] `make check` is green.
- [ ] `tests/test_integration.py` passes end-to-end (bury → open → verify
      tampering is caught).
- [ ] `chronolock --version` prints `0.1.0`.
- [ ] You can do a live demo:
      `chronolock bury mysecret "the answer is 42" --difficulty 100000`
      → copy the vault file → `chronolock list` → `chronolock status <id>`
      → `chronolock open <id> --reveal`.

---

## 8. If you get stuck

Real engineers don't flail silently. They:

1. **Read the test that's failing** — it tells you the expected contract.
2. **Read the module docstring** — it documents the algorithm and design.
3. **Check the ARCHITECTURE.md data-flow diagrams.**
4. **Ask a specific question** — e.g. "I'm in `crypto.decrypt`, the HMAC
   check: should I raise `IntegrityError` before or after attempting the
   decrypt?" The answer is almost always already in `SPEC.md §5.3`.

---

## 9. Your deliverable mindset

Every PR is judged on: **does it work, is it explained, is it clean.** The
"explained" part matters as much as the code — in reviews and interviews,
people will ask you *why* the design is the way it is. The docs in this repo
exist so you can answer that question confidently. Own them.