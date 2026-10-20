"""`nightcat init`：看看這台機器有什麼，產生一份量身訂做的設定檔。"""

from __future__ import annotations

import json
import socket
from dataclasses import dataclass, field

from .checks.battery import is_dead
from .host import Host


@dataclass
class Findings:
    mounts: list[str] = field(default_factory=list)
    sensors: int = 0
    batteries: list[str] = field(default_factory=list)
    # 系統看得到、但已經沒用的電池（健康度很低或充不進電）
    dead_batteries: list[str] = field(default_factory=list)
    systemd: bool = False
    ssh: bool = False

    def describe(self) -> str:
        parts = [f"{len(self.mounts)} 個磁碟（{', '.join(self.mounts)}）"]
        parts.append(f"{self.sensors} 個溫度感測器" if self.sensors else "沒有溫度感測器")
        if self.batteries:
            parts.append(f"電池 {', '.join(self.batteries)}")
        elif self.dead_batteries:
            parts.append(f"電池 {', '.join(self.dead_batteries)}（已經沒用了）")
        else:
            parts.append("沒有電池")
        if self.systemd:
            parts.append("systemd")
        if self.ssh:
            parts.append("SSH (port 22)")
        return "、".join(parts)


def _port_open(host: str, port: int, timeout: float = 0.5) -> bool:
    try:
        with socket.create_connection((host, port), timeout=timeout):
            return True
    except OSError:
        return False


def probe(host: Host) -> Findings:
    power = host.power()
    batteries = power.batteries if power else []
    ac = power.ac_online if power else None
    return Findings(
        mounts=host.mounts(),
        sensors=len(host.temperatures()),
        batteries=[b.name for b in batteries if not is_dead(b, ac)],
        dead_batteries=[b.name for b in batteries if is_dead(b, ac)],
        systemd=host.has_systemd(),
        ssh=_port_open("127.0.0.1", 22),
    )


def _s(value: str) -> str:
    """TOML 字串。JSON 的跳脫規則剛好也是合法的 TOML basic string。"""
    return json.dumps(value, ensure_ascii=False)


def generate_config(found: Findings, host_name: str) -> str:
    out: list[str] = []
    add = out.append
    add("# 守夜貓 nightcat 設定檔")
    add("# 由 `nightcat init` 根據這台機器自動產生。改完用 `nightcat check` 試跑。")
    add("")
    add("[nightcat]")
    add(f"host_name = {_s(host_name)}")
    add("# 這段時間只發「嚴重」的通知；其他問題早上還沒好才會通知你")
    add('quiet_hours = "23:30-07:00"')
    add("# 每天這個時間之後的第一次執行，會送一份日報")
    add('daily_report = "08:00"')
    add("# 嚴重的問題一直沒好，每隔多久再提醒一次（0 = 不提醒）")
    add('remind_every = "6h"')
    add("# 歷史紀錄保留幾天")
    add("keep_days = 30")
    add("")
    add("[telegram]")
    add("# token 建議放在環境變數 NIGHTCAT_TELEGRAM_TOKEN，不要寫進檔案")
    add('# token = "123456789:AA..."')
    add("# 你的 chat id：在 Telegram 對 @userinfobot 傳訊息就會告訴你")
    add('chat_id = ""')
    add("")
    add("[dashboard]")
    add('host = "127.0.0.1"')
    add("port = 8077")
    add("")
    add("# ─────────── 系統 ───────────")
    for mount in found.mounts:
        add("")
        add("[[check]]")
        add('type = "disk"')
        add(f"path = {_s(mount)}")
        add("warn = 85")
        add("crit = 95")
        if mount.startswith(("/mnt", "/media")):
            add("# 外接硬碟沒掛上時會通知你")
            add("must_be_mount = true")
    add("")
    add("[[check]]")
    add('type = "memory"')
    add("")
    add("[[check]]")
    add('type = "load"')
    if found.sensors:
        add("")
        add("[[check]]")
        add('type = "temperature"')
        add("warn = 80")
        add("crit = 92")
    if found.batteries:
        add("")
        add("# 筆電當伺服器：電池能告訴你家裡停電了，也會提醒你設定充電上限")
        add("[[check]]")
        add('type = "battery"')
        add("low = 25")
        add("min_health = 50")
    else:
        add("")
        if found.dead_batteries:
            names = ", ".join(found.dead_batteries)
            add(f"# 偵測到電池 {names}，但已經沒用了（健康度很低或充不進電），所以不加電池檢查。")
        else:
            add("# 沒有偵測到電池，所以不加電池檢查。")
        add("# 停電時會直接關機；下面的「開機時間」檢查會在電來之後告訴你停了多久。")
        add("# BIOS 裡如果有「通電自動開機」（ThinkPad 叫 Power On with AC Attach），記得打開，")
        add("# 不然停電後要有人按電源鍵才會開機。")
    add("")
    add("# 偵測重新開機，並推算停機了多久")
    add("[[check]]")
    add('type = "uptime"')
    add("")
    add("# 家裡的網路通不通（斷網期間的通知會在網路恢復後補送）")
    add("[[check]]")
    add('type = "tcp"')
    add('name = "對外網路"')
    add('host = "1.1.1.1"')
    add("port = 53")
    add("confirm = 3")
    if found.ssh:
        add("")
        add("[[check]]")
        add('type = "tcp"')
        add('name = "SSH"')
        add("port = 22")
    add("")
    add("# ─────────── 你的服務：把 enabled 改成 true 並填好 ───────────")
    add("")
    add("[[check]]")
    add('type = "backup"')
    add('name = "喵帳本備份"')
    add("enabled = false")
    add('path = "/srv/meow/backups"')
    add('pattern = "*.db"')
    add('max_age = "26h"')
    add('min_size = "4KB"')
    add("min_count = 7")
    add("")
    add("[[check]]")
    add('type = "http"')
    add('name = "喵帳本同步伺服器"')
    add("enabled = false")
    add('url = "http://127.0.0.1:8080/health"')
    add("")
    add("[[check]]")
    add('type = "process"')
    add('name = "Telegram bot"')
    add("enabled = false")
    add("# 在完整指令列裡搜尋（正規表示式）")
    add('match = "bot\\\\.py"')
    if found.systemd:
        add("")
        add("[[check]]")
        add('type = "systemd"')
        add("enabled = false")
        add('unit = "meow-sync.service"')
    add("")
    add("# 任何指令都可以：結束碼 0 正常、1 注意、2 嚴重（相容 Nagios 外掛）")
    add("[[check]]")
    add('type = "command"')
    add('name = "自訂檢查"')
    add("enabled = false")
    add('cmd = ["/usr/local/bin/my-check.sh"]')
    add("")
    return "\n".join(out)
