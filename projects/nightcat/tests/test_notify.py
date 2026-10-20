from pathlib import Path
from urllib.parse import parse_qs

import pytest

from conftest import LocalServer
from nightcat.config import TelegramConfig
from nightcat.errors import NotifyError
from nightcat.notify import ConsoleNotifier, TelegramNotifier, deliver, flush_outbox
from nightcat.store import Store

TOKEN = "123456:SECRET"


def telegram(server: LocalServer, chat_id: str = "42") -> TelegramNotifier:
    return TelegramNotifier(TelegramConfig(token=TOKEN, chat_id=chat_id, api_base=server.url))


def test_send(http_server: LocalServer) -> None:
    http_server.route(f"/bot{TOKEN}/sendMessage", 200, {"ok": True, "result": {}})
    telegram(http_server).send("🙀 X270 出狀況了")
    (req,) = http_server.received
    form = parse_qs(req["body"])
    assert form["chat_id"] == ["42"] and form["text"] == ["🙀 X270 出狀況了"]


def test_long_messages_are_truncated(http_server: LocalServer) -> None:
    http_server.route(f"/bot{TOKEN}/sendMessage", 200, {"ok": True})
    telegram(http_server).send("喵" * 5000)
    text = parse_qs(http_server.received[0]["body"])["text"][0]
    assert len(text) == 4096 and text.endswith("…")


@pytest.mark.parametrize(
    ("code", "description", "message"),
    [
        (401, "Unauthorized", "token 不對"),
        (400, "Bad Request: chat not found", "/start"),
        (403, "Forbidden: bot was blocked by the user", "封鎖"),
        (429, "Too Many Requests", "限速"),
        (500, "Internal", "500"),
    ],
)
def test_telegram_errors_are_explained(
    http_server: LocalServer, code: int, description: str, message: str
) -> None:
    http_server.route(f"/bot{TOKEN}/sendMessage", code, {"ok": False, "description": description})
    with pytest.raises(NotifyError, match=message) as err:
        telegram(http_server).send("x")
    assert TOKEN not in str(err.value)


def test_unreachable_telegram_does_not_leak_token(free_port: int) -> None:
    n = TelegramNotifier(
        TelegramConfig(token=TOKEN, chat_id="1", api_base=f"http://127.0.0.1:{free_port}"),
        timeout=2,
    )
    with pytest.raises(NotifyError, match="連不上 Telegram") as err:
        n.send("x")
    assert TOKEN not in str(err.value)


def test_requires_token_and_chat() -> None:
    with pytest.raises(NotifyError):
        TelegramNotifier(TelegramConfig(token=TOKEN))


class Flaky:
    def __init__(self) -> None:
        self.up = False
        self.sent: list[str] = []

    def send(self, text: str) -> None:
        if not self.up:
            raise NotifyError("network down")
        self.sent.append(text)


def test_outbox_retries_after_outage(tmp_path: Path) -> None:
    with Store(tmp_path / "n.db") as store:
        notifier = Flaky()
        assert not deliver(store, notifier, "停電了", 1000.0)
        assert not deliver(store, notifier, "還在停電", 2000.0)
        assert [i.text for i in store.outbox_items()] == ["停電了", "還在停電"]
        notifier.up = True
        assert deliver(store, notifier, "恢復了", 3000.0)
        assert len(notifier.sent) == 3
        assert notifier.sent[0].startswith("⏰ 延遲送達") and notifier.sent[0].endswith("停電了")
        assert notifier.sent[2] == "恢復了"
        assert store.outbox_items() == []
        assert flush_outbox(store, notifier)


def test_console_notifier(capsys: pytest.CaptureFixture[str]) -> None:
    ConsoleNotifier().send("hello")
    assert "hello" in capsys.readouterr().out
