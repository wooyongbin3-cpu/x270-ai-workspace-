"""時間長度、檔案大小、時刻的解析與中文格式化。"""

from __future__ import annotations

import re
from datetime import time

from .errors import ConfigError

_DURATION_PART = re.compile(r"(\d+(?:\.\d+)?)\s*(d|h|m|s)", re.IGNORECASE)
_DURATION_SECONDS = {"d": 86400, "h": 3600, "m": 60, "s": 1}

_SIZE = re.compile(r"^\s*(\d+(?:\.\d+)?)\s*([kmgt]?i?b?)\s*$", re.IGNORECASE)
_SIZE_FACTOR = {"": 1, "k": 1024, "m": 1024**2, "g": 1024**3, "t": 1024**4}


def parse_duration(value: object) -> float:
    """'26h'、'1h30m'、'90s'、'2d' 或純數字（秒）→ 秒數。"""
    if isinstance(value, bool):
        raise ConfigError(f"時間長度格式不對：{value!r}")
    if isinstance(value, (int, float)):
        if value < 0:
            raise ConfigError(f"時間長度不能是負數：{value!r}")
        return float(value)
    if not isinstance(value, str):
        raise ConfigError(f"時間長度格式不對：{value!r}")
    text = value.strip().replace(" ", "")
    if re.fullmatch(r"\d+(?:\.\d+)?", text):
        return float(text)
    parts = _DURATION_PART.findall(text)
    if not parts or "".join(n + u for n, u in parts).lower() != text.lower():
        raise ConfigError(f"時間長度格式不對：{value!r}（例如 30m、26h、1h30m、2d）")
    return float(sum(float(n) * _DURATION_SECONDS[u.lower()] for n, u in parts))


def parse_size(value: object) -> int:
    """'4KB'、'10 MB'、'1.5GiB' 或純數字（bytes）→ bytes。以 1024 為單位。"""
    if isinstance(value, bool):
        raise ConfigError(f"大小格式不對：{value!r}")
    if isinstance(value, (int, float)):
        if value < 0:
            raise ConfigError(f"大小不能是負數：{value!r}")
        return int(value)
    if not isinstance(value, str):
        raise ConfigError(f"大小格式不對：{value!r}")
    m = _SIZE.match(value)
    if not m:
        raise ConfigError(f"大小格式不對：{value!r}（例如 4KB、10MB、2GB）")
    number, unit = m.groups()
    prefix = unit[:1].lower() if unit[:1].lower() in "kmgt" else ""
    return int(float(number) * _SIZE_FACTOR[prefix])


def parse_clock(value: object) -> time:
    """'08:00' → time(8, 0)。"""
    if not isinstance(value, str) or not re.fullmatch(r"\d{1,2}:\d{2}", value.strip()):
        raise ConfigError(f"時刻格式不對：{value!r}（例如 08:00）")
    hour, minute = (int(x) for x in value.strip().split(":"))
    if hour > 23 or minute > 59:
        raise ConfigError(f"時刻超出範圍：{value!r}")
    return time(hour, minute)


def parse_time_range(value: object) -> tuple[time, time]:
    """'23:30-07:00' → (23:30, 07:00)。可以跨過午夜。"""
    if not isinstance(value, str) or value.count("-") != 1:
        raise ConfigError(f"時段格式不對：{value!r}（例如 23:30-07:00）")
    start, end = value.split("-")
    return parse_clock(start), parse_clock(end)


def in_time_range(t: time, start: time, end: time) -> bool:
    """t 是否落在 [start, end) 之間；start > end 代表跨過午夜。"""
    if start == end:
        return False
    if start < end:
        return start <= t < end
    return t >= start or t < end


def fmt_bytes(n: float) -> str:
    """1234567 → '1.2 MB'。"""
    value = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if abs(value) < 1024 or unit == "TB":
            if unit == "B":
                return f"{int(value)} B"
            return f"{value:.1f} {unit}" if abs(value) < 100 else f"{value:.0f} {unit}"
        value /= 1024
    raise AssertionError("unreachable")


def fmt_duration(seconds: float) -> str:
    """秒數 → '2 天 3 小時'、'5 小時 12 分'、'12 分鐘'、'45 秒'。只保留最大的兩個單位。"""
    s = max(0, int(seconds))
    days, s = divmod(s, 86400)
    hours, s = divmod(s, 3600)
    minutes, s = divmod(s, 60)
    if days:
        return f"{days} 天 {hours} 小時" if hours else f"{days} 天"
    if hours:
        return f"{hours} 小時 {minutes} 分" if minutes else f"{hours} 小時"
    if minutes:
        return f"{minutes} 分鐘"
    return f"{s} 秒"
