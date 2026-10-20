"""筆電當伺服器時，電池就是一台小 UPS：它能告訴你停電了，也會因為 24 小時充飽而老化。"""

from __future__ import annotations

from ..host import Battery, Power
from ..model import CheckResult, Status
from .base import Check, Context, Opt


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
            return self.result(Status.UNKNOWN, "找不到電池（桌機的話把這項檢查關掉）")

        capacity = overall_capacity(power.batteries)
        healths = [b.health for b in power.batteries if b.health is not None]
        health = min(healths) if healths else None
        unplugged = on_battery(power)
        metrics: dict[str, float] = {"on_battery": float(unplugged)}
        if capacity is not None:
            metrics["capacity"] = round(capacity, 1)
        if health is not None:
            metrics["health"] = round(health, 1)
        cycles = [b.cycle_count for b in power.batteries if b.cycle_count]
        if cycles:
            metrics["cycles"] = float(max(cycles))

        cap_text = f"{capacity:.0f}%" if capacity is not None else "未知"
        health_text = f"健康度 {health:.0f}%" if health is not None else ""
        hint = self._limit_hint(power)

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

        if health is not None and health < self.opts["min_health"]:
            worn = min(
                (b for b in power.batteries if b.health is not None), key=lambda b: b.health or 0
            )
            return self.result(
                Status.WARN,
                f"電池健康度只剩 {health:.0f}%（{worn.name}），停電時撐不了多久，考慮換電池",
                metrics,
                hint,
            )

        state = "充電中" if any(b.status == "Charging" for b in power.batteries) else "插電中"
        parts = [f"{state}，電量 {cap_text}"]
        if health_text:
            parts.append(health_text)
        return self.result(Status.OK, "，".join(parts), metrics, hint)

    def _limit_hint(self, power: Power) -> str | None:
        limit = int(self.opts["recommend_limit"])
        if power.source != "sysfs":
            return f"24 小時插電的筆電，建議在 Lenovo Vantage 開「電池保護模式」，把充電上限設在 {limit}% 左右。"
        settable = [b for b in power.batteries if b.threshold_path]
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
