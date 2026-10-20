"""SQLite 歷史紀錄：每次檢查的結果、每項檢查的告警狀態、事件、還沒送出的通知。

資料只存在本機一個檔案裡（預設 ~/.local/share/nightcat/nightcat.db）。
"""

from __future__ import annotations

import json
import sqlite3
import threading
from collections.abc import Iterable
from dataclasses import dataclass
from pathlib import Path
from typing import Any

from .alerts import CheckState, Transition
from .model import CheckResult, Status, worst

SCHEMA = """
CREATE TABLE IF NOT EXISTS runs (
    id INTEGER PRIMARY KEY,
    ts REAL NOT NULL,
    worst TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS runs_ts ON runs(ts);
CREATE TABLE IF NOT EXISTS results (
    run_id INTEGER NOT NULL REFERENCES runs(id) ON DELETE CASCADE,
    check_id TEXT NOT NULL,
    name TEXT NOT NULL,
    kind TEXT NOT NULL,
    status TEXT NOT NULL,
    summary TEXT NOT NULL,
    metrics TEXT NOT NULL,
    hint TEXT,
    primary_metric TEXT
);
CREATE INDEX IF NOT EXISTS results_run ON results(run_id);
CREATE TABLE IF NOT EXISTS state (
    check_id TEXT PRIMARY KEY,
    confirmed TEXT NOT NULL,
    since REAL NOT NULL,
    pending TEXT,
    streak INTEGER NOT NULL,
    notified TEXT NOT NULL,
    notified_at REAL,
    problem_since REAL,
    pending_since REAL
);
CREATE TABLE IF NOT EXISTS events (
    id INTEGER PRIMARY KEY,
    ts REAL NOT NULL,
    check_id TEXT NOT NULL,
    name TEXT NOT NULL,
    old TEXT NOT NULL,
    new TEXT NOT NULL,
    summary TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS events_ts ON events(ts);
CREATE TABLE IF NOT EXISTS outbox (
    id INTEGER PRIMARY KEY,
    ts REAL NOT NULL,
    text TEXT NOT NULL,
    attempts INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS meta (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL
);
"""


@dataclass
class StoredResult:
    ts: float
    check_id: str
    name: str
    kind: str
    status: Status
    summary: str
    metrics: dict[str, float]
    hint: str | None
    primary: str | None

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.check_id,
            "name": self.name,
            "kind": self.kind,
            "status": self.status.value,
            "summary": self.summary,
            "metrics": self.metrics,
            "hint": self.hint,
            "primary": self.primary,
        }


@dataclass
class OutboxItem:
    id: int
    ts: float
    text: str
    attempts: int


class Store:
    def __init__(self, path: Path, readonly: bool = False) -> None:
        self.path = path
        self._lock = threading.RLock()
        if readonly:
            self.con = sqlite3.connect(
                path.resolve().as_uri() + "?mode=ro", uri=True, timeout=10, check_same_thread=False
            )
        else:
            path.parent.mkdir(parents=True, exist_ok=True)
            # 檢查在別的 thread 裡跑，也會查詢歷史（例如開機時間檢查），所以允許跨 thread，用鎖保護
            self.con = sqlite3.connect(path, timeout=10, check_same_thread=False)
            self.con.execute("PRAGMA journal_mode=WAL")
            self.con.executescript(SCHEMA)
        self.con.execute("PRAGMA foreign_keys=ON")

    def __enter__(self) -> Store:
        return self

    def __exit__(self, *exc: object) -> None:
        self.close()

    def close(self) -> None:
        self.con.close()

    def commit(self) -> None:
        with self._lock:
            self.con.commit()

    def rollback(self) -> None:
        with self._lock:
            self.con.rollback()

    def _query(self, sql: str, params: Iterable[Any] = ()) -> list[tuple[Any, ...]]:
        with self._lock:
            return self.con.execute(sql, tuple(params)).fetchall()

    def _exec(self, sql: str, params: Iterable[Any] = ()) -> sqlite3.Cursor:
        with self._lock:
            return self.con.execute(sql, tuple(params))

    # ---------- 執行紀錄 ----------

    def record_run(self, ts: float, results: list[CheckResult]) -> int:
        with self._lock:
            cur = self.con.execute(
                "INSERT INTO runs (ts, worst) VALUES (?, ?)",
                (ts, worst(r.status for r in results).value),
            )
            run_id = int(cur.lastrowid or 0)
            self.con.executemany(
                "INSERT INTO results VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                [
                    (
                        run_id,
                        r.check_id,
                        r.name,
                        r.kind,
                        r.status.value,
                        r.summary,
                        json.dumps(r.metrics, ensure_ascii=False),
                        r.hint,
                        r.primary,
                    )
                    for r in results
                ],
            )
        return run_id

    def last_run_ts(self) -> float | None:
        rows = self._query("SELECT MAX(ts) FROM runs")
        return rows[0][0] if rows and rows[0][0] is not None else None

    def last_run_before(self, ts: float) -> float | None:
        rows = self._query("SELECT MAX(ts) FROM runs WHERE ts < ?", (ts,))
        return rows[0][0] if rows and rows[0][0] is not None else None

    def run_count_since(self, ts: float) -> int:
        return int(self._query("SELECT COUNT(*) FROM runs WHERE ts >= ?", (ts,))[0][0])

    def latest_results(self) -> tuple[float, list[StoredResult]] | None:
        rows = self._query("SELECT id, ts FROM runs ORDER BY ts DESC, id DESC LIMIT 1")
        if not rows:
            return None
        run_id, ts = rows[0]
        return ts, self._results_where("r.run_id = ?", (run_id,))

    def results_since(self, ts: float) -> list[StoredResult]:
        return self._results_where("u.ts >= ?", (ts,))

    def _results_where(self, where: str, params: tuple[Any, ...]) -> list[StoredResult]:
        rows = self._query(
            "SELECT u.ts, r.check_id, r.name, r.kind, r.status, r.summary, r.metrics, r.hint,"
            " r.primary_metric FROM results r JOIN runs u ON u.id = r.run_id"
            f" WHERE {where} ORDER BY u.ts, r.rowid",
            params,
        )
        return [
            StoredResult(ts, cid, name, kind, Status(st), summ, json.loads(m), hint, prim)
            for ts, cid, name, kind, st, summ, m, hint, prim in rows
        ]

    def metric_series(
        self, check_id: str, keys: tuple[str, ...], since: float
    ) -> list[list[float]]:
        """[[ts, keys[0], keys[1], ...], ...]，缺值的那次不列入。"""
        out: list[list[float]] = []
        for r in self._results_where("r.check_id = ? AND u.ts >= ?", (check_id, since)):
            if all(k in r.metrics for k in keys):
                out.append([r.ts, *(float(r.metrics[k]) for k in keys)])
        return out

    # ---------- 告警狀態 ----------

    def get_states(self) -> dict[str, CheckState]:
        rows = self._query(
            "SELECT check_id, confirmed, since, pending, streak, notified, notified_at,"
            " problem_since, pending_since FROM state"
        )
        return {
            cid: CheckState(
                cid,
                Status(conf),
                since,
                Status(pend) if pend else None,
                streak,
                Status(notif),
                nat,
                ps,
                pts,
            )
            for cid, conf, since, pend, streak, notif, nat, ps, pts in rows
        }

    def put_state(self, s: CheckState) -> None:
        self._exec(
            "INSERT OR REPLACE INTO state VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
            (
                s.check_id,
                s.confirmed.value,
                s.since,
                s.pending.value if s.pending else None,
                s.streak,
                s.notified.value,
                s.notified_at,
                s.problem_since,
                s.pending_since,
            ),
        )

    # ---------- 事件 ----------

    def add_event(self, t: Transition) -> None:
        self._exec(
            "INSERT INTO events (ts, check_id, name, old, new, summary) VALUES (?, ?, ?, ?, ?, ?)",
            (t.ts, t.check_id, t.name, t.old.value, t.new.value, t.summary),
        )

    def events_since(self, ts: float) -> list[Transition]:
        rows = self._query(
            "SELECT check_id, name, old, new, ts, summary FROM events WHERE ts >= ? ORDER BY ts, id",
            (ts,),
        )
        return [Transition(c, n, Status(o), Status(w), t, s) for c, n, o, w, t, s in rows]

    # ---------- 待送通知 ----------

    def outbox_add(self, ts: float, text: str, keep: int = 20) -> None:
        self._exec("INSERT INTO outbox (ts, text) VALUES (?, ?)", (ts, text))
        # 斷線很久的話只留最新的幾則，免得網路回來時一次轟炸
        self._exec(
            "DELETE FROM outbox WHERE id NOT IN (SELECT id FROM outbox ORDER BY id DESC LIMIT ?)",
            (keep,),
        )

    def outbox_items(self) -> list[OutboxItem]:
        rows = self._query("SELECT id, ts, text, attempts FROM outbox ORDER BY id")
        return [OutboxItem(*row) for row in rows]

    def outbox_remove(self, item_id: int) -> None:
        self._exec("DELETE FROM outbox WHERE id = ?", (item_id,))

    def outbox_bump(self, item_id: int) -> None:
        self._exec("UPDATE outbox SET attempts = attempts + 1 WHERE id = ?", (item_id,))

    # ---------- 其他 ----------

    def meta_get(self, key: str) -> str | None:
        rows = self._query("SELECT value FROM meta WHERE key = ?", (key,))
        return rows[0][0] if rows else None

    def meta_set(self, key: str, value: str) -> None:
        self._exec("INSERT OR REPLACE INTO meta VALUES (?, ?)", (key, value))

    def prune(self, before: float) -> None:
        with self._lock:
            self.con.execute("DELETE FROM runs WHERE ts < ?", (before,))
            self.con.execute("DELETE FROM events WHERE ts < ?", (before,))
