"""備份檢查：備份最常見的死法是「默默失敗了好幾個禮拜都沒人發現」。

除了看最新的備份夠不夠新、是不是空的，還會：
- 跟前幾份比大小，突然縮水很多代表資料可能少了；
- 實際打開最新的備份驗證（SQLite 跑 quick_check、.gz 整個解壓一遍、.zip 跑 CRC 檢查）。
"""

from __future__ import annotations

import gzip
import sqlite3
import statistics
import zipfile
import zlib
from pathlib import Path

from ..model import CheckResult, Status, worst
from ..units import fmt_bytes, fmt_duration
from .base import Check, Context, Opt

SQLITE_MAGIC = b"SQLite format 3\x00"


def verify_file(path: Path) -> tuple[bool | None, str]:
    """回傳 (是否完好, 說明)。None 代表這種格式不會驗證。"""
    with path.open("rb") as f:
        head = f.read(16)
    if head == SQLITE_MAGIC:
        return _verify_sqlite(path)
    if head[:2] == b"\x1f\x8b":
        return _verify_gzip(path)
    if head[:4] == b"PK\x03\x04":
        return _verify_zip(path)
    return None, ""


def _verify_sqlite(path: Path) -> tuple[bool, str]:
    uri = path.resolve().as_uri() + "?mode=ro&immutable=1"
    try:
        con = sqlite3.connect(uri, uri=True, timeout=5)
        try:
            rows = con.execute("PRAGMA quick_check").fetchall()
        finally:
            con.close()
    except sqlite3.DatabaseError as e:
        return False, f"SQLite 打不開：{e}"
    if rows and rows[0][0] == "ok":
        return True, "SQLite 完整"
    detail = rows[0][0] if rows else "沒有結果"
    return False, f"SQLite 損壞：{detail}"


def _verify_gzip(path: Path) -> tuple[bool, str]:
    try:
        with gzip.open(path, "rb") as f:
            while f.read(1024 * 1024):
                pass
    except (OSError, EOFError, zlib.error) as e:
        return False, f"gzip 損壞：{e}"
    return True, "gzip 完整"


def _verify_zip(path: Path) -> tuple[bool, str]:
    try:
        with zipfile.ZipFile(path) as z:
            bad = z.testzip()
    except (zipfile.BadZipFile, OSError, EOFError, zlib.error) as e:
        return False, f"zip 損壞：{e}"
    if bad is not None:
        return False, f"zip 裡的 {bad} 損壞"
    return True, "zip 完整"


def _limit(seconds: float) -> str:
    """設定的期限：26h 就寫「26 小時」，比「1 天 2 小時」好懂。"""
    hours = seconds / 3600
    if hours.is_integer() and 1 <= hours <= 72:
        return f"{int(hours)} 小時"
    return fmt_duration(seconds)


class BackupCheck(Check):
    kind = "backup"
    label = "備份"
    primary = "age_h"
    options = {
        "path": Opt("str"),
        # 可以用 ** 往下找，例如 "**/*.db"
        "pattern": Opt("str", "*"),
        "max_age": Opt("duration", "26h"),
        "min_size": Opt("size", 1),
        # 最新一份比前幾份的中位數小於這個比例就警告（0 代表不檢查）
        "shrink": Opt("num", 0.5),
        "min_count": Opt("int", 0),
        "verify": Opt("bool", True),
        "verify_max_size": Opt("size", "2GB"),
    }

    def default_name(self) -> str:
        return f"備份 {self.opts['path']}"

    def ident(self) -> str:
        return f"{self.opts['path']}/{self.opts['pattern']}"

    def run(self, ctx: Context) -> CheckResult:
        folder = Path(self.opts["path"]).expanduser()
        if not folder.is_dir():
            return self.result(Status.CRIT, f"備份資料夾不存在：{folder}")
        files = []
        for p in folder.glob(self.opts["pattern"]):
            try:
                if p.is_file():
                    st = p.stat()
                    files.append((st.st_mtime, st.st_size, p))
            except OSError:
                continue
        if not files:
            return self.result(Status.CRIT, f"找不到任何備份（{folder / self.opts['pattern']}）")
        files.sort(key=lambda f: f[0])
        mtime, size, newest = files[-1]
        age = max(0.0, ctx.now - mtime)
        metrics = {"age_h": round(age / 3600, 2), "size_bytes": float(size), "count": len(files)}

        problems: list[tuple[Status, str]] = []
        if age > self.opts["max_age"]:
            problems.append(
                (
                    Status.WARN,
                    f"最新備份是 {fmt_duration(age)}前（超過 {_limit(self.opts['max_age'])}），備份可能停了",
                )
            )
        if size < self.opts["min_size"]:
            problems.append(
                (Status.CRIT, f"最新備份 {newest.name} 只有 {fmt_bytes(size)}，可能是空的")
            )

        previous = [s for _, s, _ in files[-6:-1]]
        shrink = self.opts["shrink"]
        if shrink and previous and size >= self.opts["min_size"]:
            typical = statistics.median(previous)
            if typical > 0 and size < typical * shrink:
                drop = (1 - size / typical) * 100
                problems.append(
                    (
                        Status.WARN,
                        f"最新備份比之前小了 {drop:.0f}%（{fmt_bytes(typical)} → {fmt_bytes(size)}），資料可能少了",
                    )
                )

        if self.opts["min_count"] and len(files) < self.opts["min_count"]:
            problems.append(
                (Status.WARN, f"只有 {len(files)} 份備份（希望至少 {self.opts['min_count']} 份）")
            )

        verified = ""
        if self.opts["verify"] and size >= self.opts["min_size"]:
            if size > self.opts["verify_max_size"]:
                verified = "太大沒驗證"
            else:
                try:
                    ok, detail = verify_file(newest)
                except OSError as e:
                    ok, detail = False, f"讀不了：{e}"
                if ok is False:
                    problems.append((Status.CRIT, f"最新備份 {newest.name} {detail}"))
                elif ok:
                    verified = "已驗證"

        if problems:
            status = worst(s for s, _ in problems)
            return self.result(status, "；".join(text for _, text in problems), metrics)
        extra = f"，{verified}" if verified else ""
        summary = f"最新 {newest.name}，{fmt_duration(age)}前，{fmt_bytes(size)}（共 {len(files)} 份{extra}）"
        return self.result(Status.OK, summary, metrics)
