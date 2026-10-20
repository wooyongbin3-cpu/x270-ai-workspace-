# x270-ai-workspace

[![chronolock](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/chronolock.yml/badge.svg)](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/chronolock.yml)
[![life-clock](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/life-clock.yml/badge.svg)](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/life-clock.yml)
[![nightcat](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/nightcat.yml/badge.svg)](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/nightcat.yml)
[![swiftdl-pro](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/swiftdl-pro.yml/badge.svg)](https://github.com/wooyongbin3-cpu/x270-ai-workspace-/actions/workflows/swiftdl-pro.yml)

個人項目合集（monorepo）。每個項目原本是獨立倉庫，合併時保留了完整 git 歷史：
`git log -- projects/<名稱>` 即可查看該項目從第一個提交起的記錄。

| 項目 | 說明 | 技術 | 常用命令 |
|------|------|------|----------|
| [`projects/chronolock`](projects/chronolock) | 時間鎖保險箱：用順序 SHA-256 哈希鏈 + AES-256-GCM 封存秘密，算完才能打開 | Python 3.10+ · `cryptography` | `make dev-install` · `make check` |
| [`projects/life-clock`](projects/life-clock) | 生命時鐘：從出生起實時計時的單頁應用，Capacitor 打包 Android（最高 120Hz） | HTML/CSS/JS · Capacitor 8 | `npm test` · `npm run sync` |
| [`projects/nightcat`](projects/nightcat) | 守夜貓：替 X270 守夜，磁碟、溫度、電池（停電）、備份、服務出狀況就用 Telegram 通知，附本機儀表板 | Python 3.10+ · 標準庫 | `nightcat check` · `pytest` |
| [`projects/swiftdl-pro`](projects/swiftdl-pro) | SwiftDL Pro 桌面下載器：佇列、暫停/續傳、自動重試 | Electron 43 · Node 22.12+ | `npm install && npm start` · `npm test` |
| [`projects/ybwoo-profile`](projects/ybwoo-profile) | 個人側寫靜態頁 | HTML/CSS | 直接打開 `index.html` |

## 結構

```text
.
├── .github/
│   ├── workflows/        # 每個項目一個 CI，只在該項目目錄有改動時觸發
│   └── ISSUE_TEMPLATE/   # chronolock 的 bug / ticket 模板
└── projects/
    ├── chronolock/
    ├── life-clock/
    ├── nightcat/
    ├── swiftdl-pro/
    └── ybwoo-profile/
```

## 約定

- 每個項目自帶 README、依賴與 `.gitignore`，在項目目錄內運行命令。
- 構建產物（`dist/`、`*.apk`、`node_modules/`）不入庫；APK 發布到 GitHub Releases。
- `app-debug`（life-clock debug APK 的反編譯產物，74 MB）已從工作樹移除，可由 `projects/life-clock` 重新構建；
  原文件仍在歷史中，需要時：`git log --oneline -- projects/app-debug` 找到合併提交後
  `git checkout <合併提交>^2 -- projects/app-debug`。
