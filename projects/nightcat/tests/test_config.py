from datetime import time
from pathlib import Path

import pytest

from nightcat.checks import build_checks
from nightcat.config import load_config, parse_config
from nightcat.errors import ConfigError


def test_minimal_config_uses_defaults(tmp_path: Path) -> None:
    cfg = parse_config({"nightcat": {"host_name": "X270", "data_dir": str(tmp_path)}})
    assert cfg.host_name == "X270"
    assert cfg.db_path == tmp_path / "nightcat.db"
    assert cfg.quiet_hours is None and cfg.daily_report is None
    assert cfg.remind_every == 6 * 3600
    assert not cfg.telegram.enabled
    assert cfg.checks == []


def test_full_config(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("MY_TOKEN", "123:abc")
    cfg = parse_config(
        {
            "nightcat": {
                "host_name": "X270",
                "quiet_hours": "23:30-07:00",
                "daily_report": "08:00",
                "remind_every": 0,
                "keep_days": 7,
            },
            "telegram": {"token_env": "MY_TOKEN", "chat_id": 42},
            "dashboard": {"port": 9000, "stale_after": "30m"},
            "check": [
                {"type": "disk", "path": "/", "warn": 70},
                {"type": "memory", "enabled": False},
                {"type": "http", "name": "同步", "url": "http://x", "confirm": 3},
            ],
        }
    )
    assert cfg.quiet_hours == (time(23, 30), time(7, 0))
    assert cfg.daily_report == time(8, 0)
    assert cfg.remind_every is None
    assert cfg.keep_days == 7
    assert cfg.telegram.token == "123:abc" and cfg.telegram.chat_id == "42"
    assert cfg.telegram.enabled
    assert cfg.dashboard_port == 9000 and cfg.stale_after == 1800
    assert [c.type for c in cfg.checks] == ["disk", "http"]
    checks = build_checks(cfg.checks)
    assert checks[0].opts["warn"] == 70.0
    assert checks[1].name == "同步" and checks[1].confirm == 3


def test_token_from_default_env(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("NIGHTCAT_TELEGRAM_TOKEN", "t")
    monkeypatch.setenv("NIGHTCAT_TELEGRAM_CHAT_ID", "99")
    cfg = parse_config({})
    assert cfg.telegram.token == "t" and cfg.telegram.chat_id == "99"


@pytest.mark.parametrize(
    ("data", "message"),
    [
        ({"nightcat": {"quiet_hour": "1:00-2:00"}}, "quiet_hour"),
        ({"telgram": {}}, "telgram"),
        ({"check": {"type": "disk"}}, "[[check]]"),
        ({"check": [{"path": "/"}]}, "少了 type"),
        ({"check": [{"type": "disk", "confirm": 0}]}, "confirm"),
        ({"nightcat": {"keep_days": "30"}}, "keep_days"),
        ({"nightcat": {"daily_report": "8am"}}, "時刻"),
    ],
)
def test_config_errors(data: dict, message: str) -> None:
    with pytest.raises(ConfigError, match=message.replace("[", r"\[").replace("]", r"\]")):
        parse_config(data)


@pytest.mark.parametrize(
    ("check", "message"),
    [
        ({"type": "dsk"}, "不認得的 type"),
        ({"type": "disk", "wran": 80}, "wran"),
        ({"type": "backup"}, "少了必填選項 path"),
        ({"type": "disk", "warn": "80"}, "要是數字"),
        ({"type": "backup", "path": "/x", "max_age": "soon"}, "時間長度"),
        ({"type": "process", "match": "("}, "正規表示式"),
        ({"type": "battery", "on_battery": "panic"}, "warn"),
        ({"type": "command", "cmd": []}, "不能是空的"),
    ],
)
def test_check_option_errors(check: dict, message: str) -> None:
    cfg = parse_config({"check": [check]})
    with pytest.raises(ConfigError, match=message) as err:
        build_checks(cfg.checks)
    assert "第 1 個 [[check]]" in str(err.value)


def test_duplicate_ids_get_numbered() -> None:
    cfg = parse_config({"check": [{"type": "memory"}, {"type": "memory", "warn": 50}]})
    ids = [c.check_id for c in build_checks(cfg.checks)]
    assert ids == ["memory", "memory#2"]


def test_load_config_errors(tmp_path: Path) -> None:
    with pytest.raises(ConfigError, match="nightcat init"):
        load_config(tmp_path / "missing.toml")
    bad = tmp_path / "bad.toml"
    bad.write_text("[nightcat\n", encoding="utf-8")
    with pytest.raises(ConfigError, match="格式錯誤"):
        load_config(bad)


def test_load_config_accepts_bom(tmp_path: Path) -> None:
    path = tmp_path / "c.toml"
    path.write_bytes('﻿[nightcat]\nhost_name = "貓"\n'.encode())
    cfg = load_config(path)
    assert cfg.host_name == "貓" and cfg.path == path
