"""Tests for :mod:`chronolock.ui` — pure rendering helpers (TICKET-007)."""

from __future__ import annotations

import io

import pytest

from chronolock import ui
from chronolock.model import VaultMetadata


@pytest.fixture(autouse=True)
def plain_output(monkeypatch) -> None:
    """Render without ANSI escapes so assertions see plain text."""
    monkeypatch.setattr(ui, "_COLOUR_ENABLED", False)


class TestEnableColour:
    def test_force_color_wins(self, monkeypatch) -> None:
        monkeypatch.setenv("FORCE_COLOR", "1")
        monkeypatch.setenv("NO_COLOR", "1")
        ui.enable_colour(io.StringIO())
        assert ui._COLOUR_ENABLED is True

    def test_no_color_disables(self, monkeypatch) -> None:
        monkeypatch.delenv("FORCE_COLOR", raising=False)
        monkeypatch.setenv("NO_COLOR", "")
        ui.enable_colour(io.StringIO())
        assert ui._COLOUR_ENABLED is False

    def test_non_tty_disables(self, monkeypatch) -> None:
        monkeypatch.delenv("FORCE_COLOR", raising=False)
        monkeypatch.delenv("NO_COLOR", raising=False)
        ui.enable_colour(io.StringIO())
        assert ui._COLOUR_ENABLED is False


class TestProgressBar:
    @pytest.mark.parametrize(
        ("done", "total", "filled", "pct"),
        [(0, 100, 0, "0%"), (32, 100, 3, "32%"), (100, 100, 10, "100%"), (5, 0, 10, "100%")],
    )
    def test_shape(self, done: int, total: int, filled: int, pct: str) -> None:
        bar = ui.render_progress_bar(done, total, width=10)
        assert bar.startswith("█" * filled + "░" * (10 - filled))
        assert bar.endswith(pct)

    def test_clamps_overflow(self) -> None:
        assert ui.render_progress_bar(150, 100, width=4).startswith("████ ")

    def test_label(self) -> None:
        assert ui.render_progress_bar(1, 2, width=4, label="solving").endswith("50% solving")


def test_bury_summary_contains_fields() -> None:
    out = ui.render_bury_summary("abc123", "letter", 1_700_000_000, 5000, 90.0)
    for expected in ("abc123", "letter", "5,000", "1 minute"):
        assert expected in out
    assert "\033[" not in out


def test_header_contains_fields(sample_metadata: VaultMetadata) -> None:
    out = ui.render_header(sample_metadata)
    assert sample_metadata.vault_id in out
    assert sample_metadata.name in out
    assert "locked" in out


class TestRenderList:
    def test_empty(self) -> None:
        assert "no vaults" in ui.render_list([], now=0)

    def test_status_column(self, sample_metadata: VaultMetadata) -> None:
        before = ui.render_list([sample_metadata], now=sample_metadata.created_at)
        after = ui.render_list([sample_metadata], now=sample_metadata.unlock_after)
        assert before.splitlines()[0].split() == ["NAME", "ID", "STATUS", "OPENS"]
        assert "locked" in before and "in 1 day" in before
        assert "ready" in after and "now" in after
