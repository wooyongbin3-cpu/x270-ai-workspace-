from datetime import time

import pytest

from nightcat.errors import ConfigError
from nightcat.units import (
    fmt_bytes,
    fmt_duration,
    in_time_range,
    parse_clock,
    parse_duration,
    parse_size,
    parse_time_range,
)


@pytest.mark.parametrize(
    ("text", "seconds"),
    [
        ("90s", 90),
        ("30m", 1800),
        ("26h", 93600),
        ("2d", 172800),
        ("1h30m", 5400),
        ("45", 45),
        (120, 120),
        (1.5, 1.5),
    ],
)
def test_parse_duration(text: object, seconds: float) -> None:
    assert parse_duration(text) == seconds


@pytest.mark.parametrize("bad", ["", "abc", "26hx", "-5", True, -1, None, "1 hour"])
def test_parse_duration_rejects(bad: object) -> None:
    with pytest.raises(ConfigError):
        parse_duration(bad)


@pytest.mark.parametrize(
    ("text", "size"),
    [
        ("4KB", 4096),
        ("10 MB", 10 * 1024**2),
        ("1.5GiB", int(1.5 * 1024**3)),
        ("100", 100),
        (7, 7),
        ("5 B", 5),
        ("2k", 2048),
    ],
)
def test_parse_size(text: object, size: int) -> None:
    assert parse_size(text) == size


@pytest.mark.parametrize("bad", ["", "4XB", "big", True, -3])
def test_parse_size_rejects(bad: object) -> None:
    with pytest.raises(ConfigError):
        parse_size(bad)


def test_clock_and_range() -> None:
    assert parse_clock("8:05") == time(8, 5)
    assert parse_time_range("23:30-07:00") == (time(23, 30), time(7, 0))
    for bad in ["24:00", "8", "08:60", 800]:
        with pytest.raises(ConfigError):
            parse_clock(bad)
    with pytest.raises(ConfigError):
        parse_time_range("23:30")


def test_time_range_wraps_midnight() -> None:
    start, end = time(23, 30), time(7, 0)
    assert in_time_range(time(23, 45), start, end)
    assert in_time_range(time(3, 0), start, end)
    assert not in_time_range(time(7, 0), start, end)
    assert not in_time_range(time(12, 0), start, end)
    assert in_time_range(time(13, 0), time(12, 0), time(14, 0))
    assert not in_time_range(time(13, 0), time(12, 0), time(12, 0))


def test_formatting() -> None:
    assert fmt_bytes(512) == "512 B"
    assert fmt_bytes(1536) == "1.5 KB"
    assert fmt_bytes(250 * 1024**3) == "250 GB"
    assert fmt_duration(45) == "45 秒"
    assert fmt_duration(12 * 60 + 5) == "12 分鐘"
    assert fmt_duration(5 * 3600 + 12 * 60) == "5 小時 12 分"
    assert fmt_duration(3 * 3600) == "3 小時"
    assert fmt_duration(2 * 86400 + 3 * 3600 + 59) == "2 天 3 小時"
    assert fmt_duration(-5) == "0 秒"
