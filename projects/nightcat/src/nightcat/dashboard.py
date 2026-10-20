"""本機儀表板：`nightcat serve` 之後打開 http://127.0.0.1:8077 。

只讀不寫，資料來自 `nightcat run` 存下的 SQLite。頁面完全自帶（沒有 CDN、沒有外部字型），
離線也能開。預設只聽 127.0.0.1；要給區網其他裝置看，自己決定改成 0.0.0.0。
"""

from __future__ import annotations

import json
import logging
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from typing import Any
from urllib.parse import parse_qs, urlsplit

from . import __version__
from .config import Config
from .model import Status, mood, worst
from .store import Store

log = logging.getLogger("nightcat")

MAX_POINTS = 300
CSP = (
    "default-src 'self'; img-src 'self' data:; "
    "style-src 'unsafe-inline'; script-src 'unsafe-inline'; frame-ancestors 'none'"
)


def _open(cfg: Config) -> Store | None:
    if not cfg.db_path.exists():
        return None
    return Store(cfg.db_path, readonly=True)


def status_payload(cfg: Config, now: float) -> dict[str, Any]:
    base: dict[str, Any] = {
        "host": cfg.host_name,
        "version": __version__,
        "now": now,
        "stale_after": cfg.stale_after,
    }
    empty = {
        **base,
        "ts": None,
        "results": [],
        "events": [],
        "stale": True,
        "worst": Status.UNKNOWN.value,
        "mood": mood(Status.UNKNOWN),
    }
    store = _open(cfg)
    if store is None:
        return empty
    with store:
        latest = store.latest_results()
        events = store.events_since(now - 86400)
    if latest is None:
        return empty
    ts, results = latest
    overall = worst(r.status for r in results)
    return {
        **base,
        "ts": ts,
        "stale": now - ts > cfg.stale_after,
        "worst": overall.value,
        "mood": mood(overall),
        "results": [r.to_dict() for r in sorted(results, key=lambda r: -r.status.rank)],
        "events": [
            {
                "ts": e.ts,
                "name": e.name,
                "old": e.old.value,
                "new": e.new.value,
                "summary": e.summary,
            }
            for e in reversed(events)
        ],
    }


def history_payload(cfg: Config, now: float, hours: float) -> dict[str, Any]:
    store = _open(cfg)
    if store is None:
        return {}
    with store:
        rows = store.results_since(now - hours * 3600)
    series: dict[str, dict[str, Any]] = {}
    for r in rows:
        entry = series.setdefault(r.check_id, {"primary": r.primary, "points": []})
        value = r.metrics.get(r.primary) if r.primary else None
        entry["points"].append([r.ts, r.status.value, value])
    for entry in series.values():
        pts = entry["points"]
        if len(pts) > MAX_POINTS:
            step = len(pts) / MAX_POINTS
            # 抽樣時保留不正常的點，免得問題在圖上消失
            keep = {int(i * step) for i in range(MAX_POINTS)} | {len(pts) - 1}
            entry["points"] = [p for i, p in enumerate(pts) if i in keep or p[1] != "ok"]
    return series


class DashboardHandler(BaseHTTPRequestHandler):
    cfg: Config
    server_version = f"nightcat/{__version__}"

    def do_GET(self) -> None:
        url = urlsplit(self.path)
        now = time.time()
        if url.path in ("/", "/index.html"):
            self._send(200, PAGE.encode(), "text/html; charset=utf-8")
        elif url.path == "/api/status":
            self._json(status_payload(self.cfg, now))
        elif url.path == "/api/history":
            try:
                hours = float(parse_qs(url.query).get("hours", ["24"])[0])
            except ValueError:
                hours = 24.0
            self._json(history_payload(self.cfg, now, min(max(hours, 1.0), 24.0 * 7)))
        elif url.path == "/healthz":
            self._send(200, b"ok\n", "text/plain; charset=utf-8")
        else:
            self._send(404, "找不到這個頁面\n".encode(), "text/plain; charset=utf-8")

    def _json(self, payload: Any) -> None:
        self._send(200, json.dumps(payload, ensure_ascii=False).encode(), "application/json")

    def _send(self, code: int, body: bytes, ctype: str) -> None:
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Content-Security-Policy", CSP)
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format: str, *args: Any) -> None:
        log.debug("%s %s", self.address_string(), format % args)


def make_server(cfg: Config, host: str, port: int) -> ThreadingHTTPServer:
    handler = type("Handler", (DashboardHandler,), {"cfg": cfg})
    return ThreadingHTTPServer((host, port), handler)


PAGE = """<!doctype html>
<html lang="zh-Hant">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>守夜貓</title>
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🐱</text></svg>">
<style>
:root {
  --bg: #FFF8F0; --card: #FFFDF9; --ink: #3B2F2A; --soft: #6E5D52; --line: #EADBCD;
  --accent: #F08A4B; --wash: #FFE6D3;
  --ok: #2E9E6A; --warn: #D98A1C; --crit: #E5534B; --unknown: #8C8C8C;
  color-scheme: light;
}
@media (prefers-color-scheme: dark) {
  :root {
    --bg: #1E1916; --card: #29221E; --ink: #F1E4DA; --soft: #CDBBAE; --line: #45382F;
    --accent: #FFA36E; --wash: #4A2E1C;
    --ok: #5BC896; --warn: #F2BE62; --crit: #FF7A70; --unknown: #A8A8A8;
    color-scheme: dark;
  }
}
* { box-sizing: border-box; }
body { margin: 0; background: var(--bg); color: var(--ink);
  font: 15px/1.6 system-ui, -apple-system, "Segoe UI", "PingFang TC", "Microsoft JhengHei", "Noto Sans TC", sans-serif; }
.wrap { max-width: 1040px; margin: 0 auto; padding: 28px 16px 48px; }
header { display: flex; gap: 18px; align-items: center; flex-wrap: wrap; }
.cat { font-size: 64px; line-height: 1; width: 92px; height: 92px; display: grid; place-items: center;
  border-radius: 50%; background: var(--wash); flex: none; }
h1 { margin: 0; font-size: 28px; letter-spacing: .02em; }
.overall { margin: 2px 0 0; font-size: 17px; }
.meta { color: var(--soft); font-size: 13px; margin-top: 2px; font-variant-numeric: tabular-nums; }
.banner { margin-top: 18px; padding: 12px 16px; border-radius: 12px; background: var(--wash); border: 1px solid var(--accent); }
.banner[hidden] { display: none; }
.grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(min(100%, 300px), 1fr)); gap: 14px; margin-top: 26px; }
.card { background: var(--card); border: 1px solid var(--line); border-left: 5px solid var(--c, var(--line));
  border-radius: 14px; padding: 14px 16px 12px; display: grid; gap: 6px; align-content: start; min-width: 0; }
.card.ok { --c: var(--ok); } .card.warn { --c: var(--warn); } .card.crit { --c: var(--crit); } .card.unknown { --c: var(--unknown); }
.title { display: flex; justify-content: space-between; gap: 8px; align-items: baseline; }
.name { font-weight: 700; overflow-wrap: anywhere; }
.badge { flex: none; font-size: 12px; font-weight: 700; color: var(--c); }
.summary { color: var(--soft); font-size: 14px; overflow-wrap: anywhere; }
.spark { width: 100%; height: 44px; display: block; }
.spark .line { fill: none; stroke: var(--c, var(--accent)); stroke-width: 1.6; vector-effect: non-scaling-stroke; }
.spark .area { fill: var(--c, var(--accent)); opacity: .10; }
.spark .bad { opacity: .30; }
.range { display: flex; justify-content: space-between; color: var(--soft); font-size: 11px; font-variant-numeric: tabular-nums; }
.hint { font-size: 13px; background: var(--wash); border-radius: 8px; padding: 6px 10px; overflow-wrap: anywhere; }
h2 { font-size: 18px; margin: 34px 0 10px; }
.events { list-style: none; margin: 0; padding: 0; border-top: 1px solid var(--line); }
.events li { display: grid; grid-template-columns: 52px 1fr; gap: 10px; padding: 9px 2px; border-bottom: 1px solid var(--line); font-size: 14px; }
.events time { color: var(--soft); font-variant-numeric: tabular-nums; }
.events .what { overflow-wrap: anywhere; }
.empty { color: var(--soft); }
footer { margin-top: 36px; color: var(--soft); font-size: 12px; }
</style>
</head>
<body>
<div class="wrap">
  <header>
    <div class="cat" id="cat" aria-hidden="true">🐱</div>
    <div>
      <h1 id="host">守夜貓</h1>
      <p class="overall" id="overall">讀取中…</p>
      <div class="meta" id="meta"></div>
    </div>
  </header>
  <div class="banner" id="banner" hidden></div>
  <section class="grid" id="grid" aria-label="檢查項目"></section>
  <h2>過去 24 小時</h2>
  <ul class="events" id="events"></ul>
  <footer id="foot">每分鐘自動更新</footer>
</div>
<script>
"use strict";
const LABEL = { ok: "正常", warn: "注意", crit: "嚴重", unknown: "未知" };
const UNIT = { used_pct: "%", per_cpu: "", max_c: "°C", capacity: "%", age_h: " 小時", latency_ms: " ms", uptime_h: " 小時", count: "" };

function el(tag, cls, text) {
  const e = document.createElement(tag);
  if (cls) e.className = cls;
  if (text !== undefined) e.textContent = text;
  return e;
}
function ago(sec) {
  sec = Math.max(0, Math.round(sec));
  if (sec < 60) return sec + " 秒前";
  if (sec < 3600) return Math.round(sec / 60) + " 分鐘前";
  if (sec < 86400) return Math.round(sec / 3600) + " 小時前";
  return Math.round(sec / 86400) + " 天前";
}
function hhmm(ts) {
  const d = new Date(ts * 1000);
  return String(d.getHours()).padStart(2, "0") + ":" + String(d.getMinutes()).padStart(2, "0");
}
function fmt(v, key) {
  const n = Math.abs(v) >= 100 ? v.toFixed(0) : v.toFixed(v % 1 ? 1 : 0);
  return n + (UNIT[key] ?? "");
}

function spark(points, key) {
  const vals = points.filter(p => p[2] !== null && p[2] !== undefined);
  if (vals.length < 2) return null;
  const NS = "http://www.w3.org/2000/svg";
  const svg = document.createElementNS(NS, "svg");
  svg.setAttribute("class", "spark");
  svg.setAttribute("viewBox", "0 0 100 40");
  svg.setAttribute("preserveAspectRatio", "none");
  svg.setAttribute("role", "img");
  const t0 = points[0][0], t1 = points[points.length - 1][0];
  let lo = Math.min(...vals.map(p => p[2])), hi = Math.max(...vals.map(p => p[2]));
  if (hi === lo) { hi += 1; lo -= 1; }
  const x = t => ((t - t0) / Math.max(1, t1 - t0)) * 100;
  const y = v => 37 - ((v - lo) / (hi - lo)) * 34;
  const pts = vals.map(p => x(p[0]).toFixed(2) + "," + y(p[2]).toFixed(2));
  const area = document.createElementNS(NS, "polygon");
  area.setAttribute("class", "area");
  area.setAttribute("points", "0,40 " + pts.join(" ") + " 100,40");
  const line = document.createElementNS(NS, "polyline");
  line.setAttribute("class", "line");
  line.setAttribute("points", pts.join(" "));
  // 不正常的時段畫成直條：服務掛掉時通常沒有數值，畫點的話會看不到
  const bw = Math.max(0.8, 100 / Math.max(1, points.length - 1));
  let bad = 0;
  for (const p of points) {
    if (p[1] === "ok") continue;
    bad++;
    const r = document.createElementNS(NS, "rect");
    r.setAttribute("class", "bad");
    r.setAttribute("x", (x(p[0]) - bw / 2).toFixed(2)); r.setAttribute("y", "0");
    r.setAttribute("width", bw.toFixed(2)); r.setAttribute("height", "40");
    r.style.fill = "var(--" + p[1] + ")";
    svg.append(r);
  }
  svg.append(area, line);
  const vmin = Math.min(...vals.map(p => p[2])), vmax = Math.max(...vals.map(p => p[2]));
  svg.setAttribute("aria-label", "24 小時趨勢：最低 " + fmt(vmin, key) + "，最高 " + fmt(vmax, key) + (bad ? "，" + bad + " 次不正常" : ""));
  const range = el("div", "range");
  range.append(el("span", "", hhmm(t0)), el("span", "", "低 " + fmt(vmin, key) + " · 高 " + fmt(vmax, key)), el("span", "", hhmm(t1)));
  return [svg, range];
}

async function load() {
  let status, history;
  try {
    [status, history] = await Promise.all([
      fetch("api/status").then(r => r.json()),
      fetch("api/history?hours=24").then(r => r.json()),
    ]);
  } catch (e) {
    document.getElementById("overall").textContent = "連不上 nightcat serve";
    return;
  }
  document.title = status.mood + " " + status.host + " · 守夜貓";
  document.getElementById("cat").textContent = status.mood;
  document.getElementById("host").textContent = status.host;
  const bad = status.results.filter(r => r.status !== "ok").length;
  document.getElementById("overall").textContent =
    status.ts === null ? "還沒有資料" : bad ? bad + " 項需要注意" : "全部正常";
  document.getElementById("meta").textContent =
    status.ts === null ? "" : "最後檢查：" + ago(status.now - status.ts) + "（" + hhmm(status.ts) + "）";

  const banner = document.getElementById("banner");
  if (status.ts === null) {
    banner.textContent = "還沒有任何紀錄。先執行一次 nightcat run，並設定每 5 分鐘自動執行。";
    banner.hidden = false;
  } else if (status.stale) {
    banner.textContent = "上次檢查是 " + ago(status.now - status.ts) + "，nightcat 好像沒有在定時執行（timer 或 cron 停了？）";
    banner.hidden = false;
  } else banner.hidden = true;

  const grid = document.getElementById("grid");
  grid.replaceChildren();
  for (const r of status.results) {
    const card = el("article", "card " + r.status);
    const title = el("div", "title");
    title.append(el("span", "name", r.name), el("span", "badge", LABEL[r.status] || r.status));
    card.append(title, el("div", "summary", r.summary));
    const h = history[r.id];
    if (h && h.primary) {
      const s = spark(h.points, h.primary);
      if (s) card.append(...s);
    }
    if (r.hint) card.append(el("div", "hint", "💡 " + r.hint));
    grid.append(card);
  }

  const list = document.getElementById("events");
  list.replaceChildren();
  if (!status.events.length) list.append(el("li", "empty", "一切平靜 ✨"));
  for (const e of status.events) {
    const li = el("li");
    const t = el("time", "", hhmm(e.ts));
    const text = e.new === "ok" ? e.name + " 恢復正常" : e.name + " → " + (LABEL[e.new] || e.new) + "：" + e.summary;
    li.append(t, el("span", "what", text));
    list.append(li);
  }
  document.getElementById("foot").textContent = "守夜貓 v" + status.version + " · 每分鐘自動更新";
}
load();
setInterval(load, 60000);
</script>
</body>
</html>
"""
