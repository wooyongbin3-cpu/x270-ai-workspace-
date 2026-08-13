# Contributing to Chronolock

Thanks for picking up a ticket. This is how we keep the codebase clean,
reviewable, and honest.

---

## 1. Getting started

```bash
cd chronolock
make dev-install   # installs the package + dev/test dependencies (editable)
make test          # run the suite (expect failures — the TODO markers are your spec)
```

If you prefer `tox`: `tox` runs the full matrix (lint + typecheck + tests)
across the supported Python versions.

---

## 2. Branch & commit conventions

### Branch naming

```
ticket/00X-short-slug
```

e.g. `ticket/002-hash-chain-puzzle`.

### Commit messages

Reference the ticket. Conventional Commits style is preferred:

```
Closes TICKET-002: implement the sequential hash-chain puzzle

- validates difficulty bounds
- solves the chain with periodic progress callbacks
- adds estimation helper
```

---

## 3. Development loop

```bash
# Targeted test while implementing a ticket:
pytest tests/test_puzzle.py -q

# Whole suite once the ticket is done:
make test

# Quality gates:
make lint        # ruff (see pyproject for the rule set)
make typecheck   # mypy --strict-ish (disallow_untyped_defs)
make check       # all of the above in one shot
```

**All three gates must pass** before you consider a ticket complete.

---

## 4. Code review checklist

Used by reviewers; follow it yourself before opening a PR.

- [ ] Layering respected (`ARCHITECTURE.md §1.1`):
      `store` doesn't import `vault`; `ui` never imported by logic layers.
- [ ] No new `NotImplementedError` in touched modules.
- [ ] No secrets printed/logged; no `print()` in library modules.
- [ ] Public functions typed and docstringed (matches `pyproject` mypy config).
- [ ] Constants used, not magic numbers (`MIN_DIFFICULTY`, `NONCE_LENGTH`, …).
- [ ] Errors raised from `chronolock.errors` (typed), not bare `Exception`.
- [ ] Tests were **not** modified to make the code pass.
- [ ] `make check` green.

---

## 5. Definition of done (this is not optional)

See `AGENTS.md §4.2`. In summary: `make check` green, the ticket's linked
tests pass, no stray TODOs in your modules, no test tampering, and you can
explain your design.

---

## 6. Opening a PR

1. Push your `ticket/00X-*` branch.
2. Open a PR titled `TICKET-00X: <summary>`.
3. In the body, checklist the acceptance criteria from the ticket and link
   `Closes TICKET-00X`.
4. Reference which tests you ran and paste the relevant green output.

---

## 7. Asking for help

Open an issue using the template in `.github/ISSUE_TEMPLATE/`. Good questions
are specific and reference the spec/architecture line you're unsure about —
e.g. *"SPEC §5.3 says HMAC before decrypt; I'm in `crypto.decrypt` — should the
HMAC mismatch raise `IntegrityError` and skip the AES call entirely?"*