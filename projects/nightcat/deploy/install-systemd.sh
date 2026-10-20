#!/bin/sh
# 把守夜貓裝成 systemd 使用者服務：每 5 分鐘檢查一次，開機後也會自己跑。
# 用法：sh deploy/install-systemd.sh          （只裝定時檢查）
#       sh deploy/install-systemd.sh --dashboard（連儀表板一起裝）
set -eu

here=$(cd "$(dirname "$0")" && pwd)
units="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

if ! command -v nightcat >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/nightcat" ]; then
    echo "找不到 nightcat 指令，先用 pipx 安裝（見 README）" >&2
    exit 1
fi

mkdir -p "$units"
cp "$here/nightcat.service" "$here/nightcat.timer" "$units/"
[ "${1:-}" = "--dashboard" ] && cp "$here/nightcat-dashboard.service" "$units/"

systemctl --user daemon-reload
systemctl --user enable --now nightcat.timer
[ "${1:-}" = "--dashboard" ] && systemctl --user enable --now nightcat-dashboard.service

# 沒有登入也要跑（伺服器通常沒人登入）
if command -v loginctl >/dev/null 2>&1; then
    loginctl enable-linger "$(id -un)" 2>/dev/null || echo "提醒：執行 sudo loginctl enable-linger $(id -un)，登出後才會繼續跑"
fi

echo "✅ 已啟用。看狀態：systemctl --user list-timers nightcat.timer"
echo "   看紀錄：journalctl --user -u nightcat.service -n 20"
