---
name: "chronolock: Ticket (TICKET-XXX)"
about: A scoped unit of implementation work with acceptance criteria.
title: "TICKET-XXX: <short summary>"
labels: ["ticket", "chronolock"]
assignees: []
---

## Ticket

- **Area:** <puzzle / crypto / store / vault / difficulty / ui / cli>
- **Priority:** <P0 / P1 / P2>
- **Estimated size:** <S / M / L / XL>
- **Depends on:** <TICKET-XXX, or "none">

## Context

<1–3 sentences: what this ticket adds and why. Reference SPEC.md / ARCHITECTURE.md sections.>

## Task

<What to implement and where. Reference the module(s).>

## Files to touch

- `src/chronolock/<module>.py`
- `tests/<test-file>.py` *(if extending the suite)*

## Acceptance criteria

- [ ] `<criterion 1>`
- [ ] `<criterion 2>`
- [ ] `make check` passes
- [ ] Tests passing: `pytest tests/<file>.py -q`

## Definition of done (per AGENTS.md §4.2)

- [ ] Implemented `TODO(TICKET-XXX)` markers
- [ ] No new `NotImplementedError` in touched modules
- [ ] No changes to tests to force passes
- [ ] Can explain the design in review