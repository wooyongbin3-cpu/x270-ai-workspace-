"""送出通知：Telegram，或在沒設定時印到畫面上。

停電時路由器通常也一起掛了，通知送不出去。這時訊息會先存進 outbox，
下次執行時再補送，並標上原本的時間。
"""

from __future__ import annotations

import json
import logging
import sys
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime
from typing import Any, Protocol

from .checks.network import describe_error
from .config import TelegramConfig
from .errors import NotifyError
from .store import Store

log = logging.getLogger("nightcat")

TELEGRAM_LIMIT = 4096


class Notifier(Protocol):
    def send(self, text: str) -> None: ...


class ConsoleNotifier:
    def __init__(self, stream: Any = None) -> None:
        self.stream = stream

    def send(self, text: str) -> None:
        out = self.stream or sys.stdout
        print("─" * 32, file=out)
        print(text, file=out)
        print("─" * 32, file=out)


def _explain(code: int, description: str) -> str:
    desc = description.lower()
    if code == 401:
        return "Telegram bot token 不對（401 Unauthorized），到 @BotFather 確認一下"
    if code == 400 and "chat not found" in desc:
        return (
            "找不到這個 chat_id：先在 Telegram 對你的 bot 傳一則訊息（例如 /start），再確認 chat_id"
        )
    if code == 403:
        return "bot 沒辦法傳訊息給你：你可能封鎖了它，或還沒對它按過 /start"
    if code == 429:
        return "傳太快，被 Telegram 限速了"
    return f"Telegram 回應錯誤 {code}：{description or '（沒有說明）'}"


class TelegramNotifier:
    def __init__(self, cfg: TelegramConfig, timeout: float = 15) -> None:
        if not cfg.token or not cfg.chat_id:
            raise NotifyError("Telegram 還沒設定好：需要 token 和 chat_id")
        self.token = cfg.token
        self.chat_id = cfg.chat_id
        self.api_base = cfg.api_base
        self.timeout = timeout

    def send(self, text: str) -> None:
        if len(text) > TELEGRAM_LIMIT:
            text = text[: TELEGRAM_LIMIT - 1] + "…"
        data = urllib.parse.urlencode(
            {"chat_id": self.chat_id, "text": text, "disable_web_page_preview": "true"}
        ).encode()
        req = urllib.request.Request(f"{self.api_base}/bot{self.token}/sendMessage", data=data)
        try:
            with urllib.request.urlopen(req, timeout=self.timeout) as resp:
                payload = json.load(resp)
        except urllib.error.HTTPError as e:
            try:
                description = json.load(e).get("description", "")
            except (ValueError, OSError, AttributeError):
                description = ""
            raise NotifyError(_explain(e.code, description)) from None
        except (urllib.error.URLError, OSError, ValueError) as e:
            # 錯誤訊息裡不放網址，token 在網址裡
            raise NotifyError(f"連不上 Telegram：{describe_error(e, self.timeout)}") from None
        if not payload.get("ok"):
            raise NotifyError(_explain(0, str(payload.get("description", ""))))


def flush_outbox(store: Store, notifier: Notifier) -> bool:
    """補送之前沒送出去的通知。全部送完回傳 True。"""
    for item in store.outbox_items():
        when = datetime.fromtimestamp(item.ts)
        try:
            notifier.send(f"⏰ 延遲送達（原本在 {when:%m/%d %H:%M}）\n{item.text}")
        except NotifyError as e:
            store.outbox_bump(item.id)
            log.warning("補送通知失敗：%s", e)
            return False
        store.outbox_remove(item.id)
    return True


def deliver(store: Store, notifier: Notifier, text: str, now: float) -> bool:
    """送出一則通知；送不出去就排進 outbox，下次再試。"""
    if not flush_outbox(store, notifier):
        store.outbox_add(now, text)
        return False
    try:
        notifier.send(text)
    except NotifyError as e:
        log.warning("通知送不出去，下次再試：%s", e)
        store.outbox_add(now, text)
        return False
    return True
