import json
from pathlib import Path
from urllib.parse import parse_qs

import pytest

from conftest import LocalServer
from nightcat.cli import _pad, _width, main
from nightcat.config import load_config, parse_config, tomllib
from nightcat.host import Host
from nightcat.probe import Findings, generate_config
from nightcat.store import Store


def write_config(tmp_path: Path, checks: str, extra: str = "") -> Path:
    path = tmp_path / "config.toml"
    path.write_text(
        f'[nightcat]\nhost_name = "X270"\ndata_dir = "{tmp_path / "data"}"\n{extra}\n{checks}',
        encoding="utf-8",
    )
    return path


OK_CHECK = (
    '[[check]]\ntype = "command"\nname = "總是正常"\ncmd = ["python3", "-c", "print(\'fine\')"]\n'
)
BAD_CHECK = '[[check]]\ntype = "command"\nname = "總是壞掉"\ncmd = ["python3", "-c", "print(\'broken\'); exit(2)"]\n'


def test_check_prints_and_uses_nagios_exit_code(
    tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    path = write_config(tmp_path, OK_CHECK)
    assert main(["--config", str(path), "check"]) == 0
    out = capsys.readouterr().out
    assert "😺 守夜貓 · X270" in out and "🟢 總是正常" in out and "全部正常" in out

    path = write_config(tmp_path, OK_CHECK + BAD_CHECK)
    assert main(["-c", str(path), "check"]) == 2
    assert "1 項需要注意" in capsys.readouterr().out


def test_check_json_and_only(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    path = write_config(tmp_path, OK_CHECK + BAD_CHECK)
    assert main(["-c", str(path), "check", "--json", "--only", "正常"]) == 0
    payload = json.loads(capsys.readouterr().out)
    assert payload["host"] == "X270" and payload["worst"] == "ok"
    assert [r["name"] for r in payload["results"]] == ["總是正常"]
    assert main(["-c", str(path), "check", "--only", "nothing-matches"]) == 1
    assert "沒有名稱或 id" in capsys.readouterr().err


def test_check_without_config_autodetects(capsys: pytest.CaptureFixture[str]) -> None:
    code = main(["check"])
    out = capsys.readouterr().out
    assert code in (0, 1, 2, 3)
    assert "還沒有設定檔" in out and "記憶體" in out


def test_run_records_and_dry_run_does_not(
    tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    path = write_config(tmp_path, OK_CHECK + BAD_CHECK)
    db = tmp_path / "data" / "nightcat.db"
    assert main(["-c", str(path), "run", "--dry-run"]) == 0
    out = capsys.readouterr().out
    assert "🙀 X270 出狀況了" in out and "總是壞掉：broken" in out and "試跑" in out
    with Store(db) as store:
        assert store.last_run_ts() is None
    assert main(["-c", str(path), "run"]) == 0
    assert "檢查了 2 項：1 正常、1 嚴重" in capsys.readouterr().out
    with Store(db) as store:
        assert store.last_run_ts() is not None
        assert (
            store.get_states()["command:" + "python3 -c print('broken'); exit(2)"].notified.value
            == "crit"
        )
    # 第二次：狀態沒變，不再通知
    assert main(["-c", str(path), "run", "-q"]) == 0
    assert capsys.readouterr().out == ""


def test_run_sends_to_telegram(
    tmp_path: Path, http_server: LocalServer, capsys: pytest.CaptureFixture[str]
) -> None:
    http_server.route("/botT0K3N/sendMessage", 200, {"ok": True})
    extra = f'[telegram]\ntoken = "T0K3N"\nchat_id = "7"\napi_base = "{http_server.url}"\n'
    path = write_config(tmp_path, BAD_CHECK, extra)
    assert main(["-c", str(path), "run"]) == 0
    assert "已送出" in capsys.readouterr().out
    assert len(http_server.received) == 1
    assert main(["-c", str(path), "test-alert"]) == 0
    assert "測試成功" in parse_qs(http_server.received[-1]["body"])["text"][0]


def test_report_prints(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    path = write_config(tmp_path, OK_CHECK)
    assert main(["-c", str(path), "report"]) == 0
    assert "日報" in capsys.readouterr().out


def test_init_writes_loadable_config(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    path = tmp_path / "new" / "config.toml"
    assert main(["-c", str(path), "init", "--name", "X270"]) == 0
    assert "已建立設定檔" in capsys.readouterr().out
    cfg = load_config(path)
    assert cfg.host_name == "X270"
    assert {"disk", "memory", "load", "uptime", "tcp"} <= {c.type for c in cfg.checks}
    assert main(["-c", str(path), "init"]) == 1
    assert "已經存在" in capsys.readouterr().err
    assert main(["-c", str(path), "init", "--force"]) == 0


def test_generated_config_for_a_thinkpad() -> None:
    found = Findings(
        mounts=["/", "/mnt/usb backup"],
        sensors=3,
        batteries=["BAT0", "BAT1"],
        systemd=True,
        ssh=True,
    )
    text = generate_config(found, 'X270 "home"')
    cfg = parse_config(tomllib.loads(text))
    assert cfg.host_name == 'X270 "home"'
    types = [c.type for c in cfg.checks]
    assert types.count("disk") == 2 and "battery" in types and "temperature" in types
    usb = next(c for c in cfg.checks if c.options.get("path") == "/mnt/usb backup")
    assert usb.options["must_be_mount"] is True
    assert [c.name for c in cfg.checks if c.type == "tcp"] == ["對外網路", "SSH"]
    # 範例服務預設是關的，但打開後要能直接用
    enabled = tomllib.loads(text.replace("enabled = false", "enabled = true"))
    from nightcat.checks import build_checks

    names = [c.name for c in build_checks(parse_config(enabled).checks)]
    assert "喵帳本備份" in names and "Telegram bot" in names
    process = next(c for c in build_checks(parse_config(enabled).checks) if c.kind == "process")
    assert process.opts["match"] == r"bot\.py"
    assert "BAT0" in found.describe()


def test_bad_config_is_reported(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    path = write_config(tmp_path, '[[check]]\ntype = "disk"\nwran = 80\n')
    assert main(["-c", str(path), "run"]) == 1
    err = capsys.readouterr().err
    assert err.startswith("❌") and "wran" in err
    assert main(["-c", str(tmp_path / "missing.toml"), "run"]) == 1
    assert "nightcat init" in capsys.readouterr().err


def test_no_command_prints_help(capsys: pytest.CaptureFixture[str]) -> None:
    assert main([]) == 1
    assert "守夜貓" in capsys.readouterr().out


def test_display_width_aligns_chinese() -> None:
    assert _width("磁碟 /") == 6
    assert _pad("記憶體", 8) == "記憶體  "
    assert Host().cpu_count() >= 1
