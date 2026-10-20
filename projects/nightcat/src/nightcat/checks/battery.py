"""筆電當伺服器時，電池就是一台小 UPS：它能告訴你停電了，也會因為 24 小時充飽而老化。"""

from __future__ import annotations

from ..host import Battery, Power
from ..model import CheckResult, Status
from .base import Check, Context, Opt

# 健康度低於這個，就當作電池已經沒用了
DEAD_HEALTH = 10.0

NO_BATTERY_HINT = (
    "沒有可用的電池，停電時會直接關機；電來之後「開機時間」檢查會告訴你停了多久。"
    "BIOS 裡如果有「通電自動開機」的選項（ThinkPad 叫 Power On with AC Attach），記得打開，"
    "不然停電後要有人按電源鍵才會開機。"
)


def is_dead(b: Battery, ac_online: bool | None) -> bool:
    """健康度只剩一點點，或插著電卻完全充不進去。"""
    if b.health is not None and b.health < DEAD_HEALTH:
        return True
    return (
        ac_online is True and b.capacity is not None and b.capacity < 1 and b.status != "Charging"
    )


def overall_capacity(batteries: list[Battery]) -> float | None:
    """多顆電池（X270 有內建 + 外接兩顆）時，用能量加總算整體電量。"""
    if not batteries:
        return None
    if all(b.energy_now is not None and b.energy_full for b in batteries):
        now = sum(b.energy_now or 0 for b in batteries)
        full = sum(b.energy_full or 0 for b in batteries)
        return now / full * 100 if full else None
    caps = [b.capacity for b in batteries if b.capacity is not None]
    return sum(caps) / len(caps) if caps else None


def on_battery(power: Power) -> bool:
    if power.ac_online is not None:
        return not power.ac_online
    return any(b.status == "Discharging" for b in power.batteries)


class BatteryCheck(Check):
    kind = "battery"
    label = "電池"
    primary = "capacity"
    options = {
        # 用電池供電時的狀態；預設只是「注意」，電量低於 low 才算嚴重
        "on_battery": Opt("status", "warn"),
        "low": Opt("num", 25),
        "min_health": Opt("num", 50),
        # 24 小時插電建議的充電上限
        "recommend_limit": Opt("num", 80),
    }

    def run(self, ctx: Context) -> CheckResult:
        power = ctx.host.power()
        if power is None:
            return self.result(
                Status.UNKNOWN, "讀不到電源資訊（Windows/macOS 需要 pip install psutil）"
            )
        if not power.batteries:
            return self.result(
                Status.UNKNOWN, "找不到電池（桌機的話把這項檢查關掉）", hint=NO_BATTERY_HINT
            )

        alive: list[Battery] = []
        dead: list[Battery] = []
        for b in power.batteries:
            (dead if is_dead(b, power.ac_online) else alive).append(b)
        healths = [b.health for b in power.batteries if b.health is not None]
        health = min(healths) if healths else None
        unplugged = on_battery(power)
        metrics: dict[str, float] = {"on_battery": float(unplugged)}
        if health is not None:
            metrics["health"] = round(health, 1)

        if not alive:
            # 電池還在，但已經沒用了：一直提醒「健康度很低」或「設定充電上限」都沒有意義
            names = "、".join(b.name for b in dead)
            detail = f"健康度 {health:.0f}%" if health is not None else "插著電也充不進去"
            return self.result(
                Status.WARN,
                f"電池 {names} 已經沒用了（{detail}），停電時會直接關機。"
                "已經知道的話，可以在設定檔把電池檢查關掉",
                metrics,
                NO_BATTERY_HINT
                + "也看一下電池有沒有膨脹（底殼或觸控板被頂起來），膨脹的鋰電池要拆掉。",
            )

        capacity = overall_capacity(alive)
        if capacity is not None:
            metrics["capacity"] = round(capacity, 1)
        cycles = [b.cycle_count for b in alive if b.cycle_count]
        if cycles:
            metrics["cycles"] = float(max(cycles))

        cap_text = f"{capacity:.0f}%" if capacity is not None else "未知"
        health_text = f"健康度 {health:.0f}%" if health is not None else ""
        hint = self._limit_hint(power, alive)

        if unplugged:
            if capacity is not None and capacity <= self.opts["low"]:
                return self.result(
                    Status.CRIT,
                    f"用電池供電中，只剩 {cap_text}！很快會斷電關機",
                    metrics,
                    hint,
                )
            return self.result(
                self.opts["on_battery"], f"用電池供電中（停電了？），電量 {cap_text}", metrics, hint
            )

        if dead:
            # X270 這種兩顆電池的：其中一顆壞了，停電時就只剩另一顆撐著
            others = "、".join(b.name for b in alive)
            return self.result(
                Status.WARN,
                f"{'、'.join(b.name for b in dead)} 已經沒用了，停電時只剩 {others} 撐著（電量 {cap_text}）",
                metrics,
                hint,
            )
        if health is not None and health < self.opts["min_health"]:
            worn = min((b for b in alive if b.health is not None), key=lambda b: b.health or 0)
            return self.result(
                Status.WARN,
                f"電池健康度只剩 {health:.0f}%（{worn.name}），停電時撐不了多久，考慮換電池",
                metrics,
                hint,
            )

        state = "充電中" if any(b.status == "Charging" for b in alive) else "插電中"
        parts = [f"{state}，電量 {cap_text}"]
        if health_text:
            parts.append(health_text)
        return self.result(Status.OK, "，".join(parts), metrics, hint)

    def _limit_hint(self, power: Power, alive: list[Battery]) -> str | None:
        limit = int(self.opts["recommend_limit"])
        if power.source != "sysfs":
            return f"24 小時插電的筆電，建議在 Lenovo Vantage 開「電池保護模式」，把充電上限設在 {limit}% 左右。"
        settable = [b for b in alive if b.threshold_path]
        too_high = [b for b in settable if b.threshold is not None and b.threshold > limit]
        if too_high:
            b = too_high[0]
            return (
                f"{b.name} 的充電上限是 {b.threshold}%。24 小時插電會讓電池老化、甚至膨脹，"
                f"建議設成 {limit}%：echo {limit} | sudo tee {b.threshold_path}"
                "（重開機會還原，想永久生效可以用 TLP）"
            )
        if not settable:
            return (
                f"24 小時插電會讓電池老化。ThinkPad 可以用 TLP 設定充電上限："
                f"在 /etc/tlp.conf 加 STOP_CHARGE_THRESH_BAT0={limit}"
            )
        return None
