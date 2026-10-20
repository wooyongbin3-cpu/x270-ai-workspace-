import gzip
import os
import sqlite3
import zipfile
from pathlib import Path

import pytest

from conftest import NOON, FakeTree
from nightcat.checks.backup import BackupCheck, verify_file
from nightcat.model import Status

HOUR = 3600.0


def make_db(path: Path, rows: int = 50) -> Path:
    con = sqlite3.connect(path)
    con.execute("CREATE TABLE tx (id INTEGER PRIMARY KEY, amount REAL, note TEXT)")
    con.executemany(
        "INSERT INTO tx (amount, note) VALUES (?, ?)", [(i * 1.5, "午餐" * 20) for i in range(rows)]
    )
    con.commit()
    con.close()
    return path


def age(path: Path, hours: float) -> Path:
    ts = NOON - hours * HOUR
    os.utime(path, (ts, ts))
    return path


@pytest.fixture
def backups(tmp_path: Path) -> Path:
    folder = tmp_path / "backups"
    folder.mkdir()
    return folder


def test_fresh_verified_sqlite_backup(tree: FakeTree, backups: Path) -> None:
    for day in range(3, 0, -1):
        age(make_db(backups / f"meow-{day}.db"), day * 24 + 3)
    age(make_db(backups / "meow-0.db"), 3)
    r = BackupCheck(path=str(backups), pattern="*.db").run(tree.ctx())
    assert r.status is Status.OK, r.summary
    assert (
        "meow-0.db" in r.summary
        and "3 小時前" in r.summary
        and "已驗證" in r.summary
        and "共 4 份" in r.summary
    )
    assert r.metrics["age_h"] == 3.0 and r.metrics["count"] == 4


def test_missing_folder_and_no_files(tree: FakeTree, backups: Path) -> None:
    r = BackupCheck(path=str(backups / "nope")).run(tree.ctx())
    assert r.status is Status.CRIT and "不存在" in r.summary
    (backups / "notes.txt").write_text("x")
    r = BackupCheck(path=str(backups), pattern="*.db").run(tree.ctx())
    assert r.status is Status.CRIT and "找不到任何備份" in r.summary


def test_stale_backup_warns(tree: FakeTree, backups: Path) -> None:
    age(make_db(backups / "old.db"), 31)
    r = BackupCheck(path=str(backups), max_age="26h").run(tree.ctx())
    assert r.status is Status.WARN and "1 天 7 小時前" in r.summary and "備份可能停了" in r.summary
    assert "超過 26 小時" in r.summary


def test_empty_backup_is_critical(tree: FakeTree, backups: Path) -> None:
    age(make_db(backups / "a.db"), 25)
    (backups / "b.db").write_bytes(b"")
    age(backups / "b.db", 1)
    r = BackupCheck(path=str(backups)).run(tree.ctx())
    assert r.status is Status.CRIT and "只有 0 B" in r.summary


def test_shrinking_backup_warns(tree: FakeTree, backups: Path) -> None:
    for i in range(5):
        age(make_db(backups / f"day{i}.db", rows=2000), 24 * (5 - i) + 1)
    age(make_db(backups / "today.db", rows=5), 1)
    r = BackupCheck(path=str(backups)).run(tree.ctx())
    assert r.status is Status.WARN and "小了" in r.summary and "資料可能少了" in r.summary
    assert BackupCheck(path=str(backups), shrink=0).run(tree.ctx()).status is Status.OK


def test_corrupt_sqlite_is_critical(tree: FakeTree, backups: Path) -> None:
    db = make_db(backups / "meow.db", rows=500)
    data = bytearray(db.read_bytes())
    data[4096:8192] = b"\xff" * 4096  # 把第二頁整個弄壞
    db.write_bytes(bytes(data))
    age(db, 1)
    r = BackupCheck(path=str(backups)).run(tree.ctx())
    assert r.status is Status.CRIT and "SQLite" in r.summary
    assert BackupCheck(path=str(backups), verify=False).run(tree.ctx()).status is Status.OK


def test_min_count(tree: FakeTree, backups: Path) -> None:
    for i in range(3):
        age(make_db(backups / f"{i}.db"), i + 1)
    r = BackupCheck(path=str(backups), min_count=7, shrink=0).run(tree.ctx())
    assert r.status is Status.WARN and "只有 3 份" in r.summary


def test_recursive_pattern(tree: FakeTree, backups: Path) -> None:
    (backups / "2026" / "10").mkdir(parents=True)
    age(make_db(backups / "2026" / "10" / "20.db"), 2)
    r = BackupCheck(path=str(backups), pattern="**/*.db").run(tree.ctx())
    assert r.status is Status.OK and "20.db" in r.summary


def test_verify_formats(tmp_path: Path) -> None:
    good_gz = tmp_path / "a.sql.gz"
    good_gz.write_bytes(gzip.compress(b"INSERT INTO x VALUES (1);\n" * 1000))
    assert verify_file(good_gz) == (True, "gzip 完整")

    bad_gz = tmp_path / "b.sql.gz"
    bad_gz.write_bytes(good_gz.read_bytes()[:-40])
    ok, detail = verify_file(bad_gz)
    assert ok is False and "gzip" in detail

    good_zip = tmp_path / "c.zip"
    with zipfile.ZipFile(good_zip, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("data.csv", "date,amount\n" * 500)
    assert verify_file(good_zip) == (True, "zip 完整")

    bad_zip = tmp_path / "d.zip"
    raw = bytearray(good_zip.read_bytes())
    raw[60:70] = b"\x00" * 10
    bad_zip.write_bytes(bytes(raw))
    ok, _ = verify_file(bad_zip)
    assert ok is False

    plain = tmp_path / "e.txt"
    plain.write_text("hello")
    assert verify_file(plain) == (None, "")

    assert verify_file(make_db(tmp_path / "f.db")) == (True, "SQLite 完整")


def test_big_files_skip_verification(tree: FakeTree, backups: Path) -> None:
    age(make_db(backups / "big.db"), 1)
    r = BackupCheck(path=str(backups), verify_max_size="1KB").run(tree.ctx())
    assert r.status is Status.OK and "太大沒驗證" in r.summary
