"""nightcat 的例外類型。CLI 會把它們轉成給人看的中文訊息。"""

from __future__ import annotations


class NightcatError(Exception):
    """所有 nightcat 例外的基底。"""


class ConfigError(NightcatError):
    """設定檔有錯：找不到、格式不對、選項打錯字。"""


class NotifyError(NightcatError):
    """通知送不出去（網路斷了、token 錯誤等）。"""
