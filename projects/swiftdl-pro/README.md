# ⚡ SwiftDL Pro - 萬能通用下載器

> 一款功能強大的跨平台桌面下載工具，支持 HTTP/HTTPS 多協議下載

[![Electron](https://img.shields.io/badge/Electron-470000?style=for-the-badge&logo=electron&logoColor=white)](https://www.electronjs.org/)
[![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)
[![License](https://img.shields.io/badge/MIT-646CFF?style=for-the-badge)](./LICENSE)

---

## 功能特點

### 核心下載能力
- 高速下載 - 利用 Node.js 原生 HTTP/HTTPS 模組實現高效文件下載
- 批量任務 - 支援一次性添加多條下載連結，按「同時下載數」排隊執行
- 暫停/恢復 - 隨時控制下載進度，支援斷點續傳（HTTP Range）
- 安全寫入 - 先寫入 `.part` 暫存檔，完成後才改名；同名檔案自動加 `(1)`，絕不覆蓋
- 自動重試 - 網路錯誤 / 5xx 自動重試 3 次（遞增等待）
- 即時監控 - 每秒更新下載進度、速度、剩餘時間
- 智能分類 - 自動識別 8+ 檔案類型（影片、音頻、圖片、文檔、壓縮包等）

### 用戶體驗
- 日夜雙主題 - 深色/淺色主題一鍵切換
- 粒子動畫背景 - 流暢的動態背景效果
- 精美 UI 設計 - 漸變色彩、圓角卡片、微動畫
- 搜索過濾 - 快速查找及管理下載任務
- 狀態標籤 - 按狀態篩選：全部 / 進行中 / 已暫停 / 已完成 / 失敗
- Toast 通知 - 任務完成/錯誤即時提醒

### 實用工具
- 拖放添加 - 從瀏覽器直接拖放連結到應用窗口
- 選擇目錄 - 系統對話框選擇保存位置（預設為系統下載資料夾）
- 響應式佈局 - 自動適配不同螢幕尺寸
- 統計儀表板 - 總任務數、進行中、已完成、已下載容量

---

## 快速開始

```bash
npm install
npm start      # 啟動應用
npm test       # 下載引擎測試（node:test，本地 HTTP 伺服器，無需 Electron）
```

---

## 項目結構

```text
src/main/              - Electron 主進程
  index.js             - 主入口、窗口管理、IPC
  preload.js           - 安全橋接 (Context Bridge)
  download-manager.js  - 下載引擎核心（佇列、續傳、重試）
src/renderer/          - 渲染進程 UI
  index.html           - 主界面 (HTML/CSS)
  app.js               - 界面邏輯
test/                  - 下載引擎測試
assets/                - 圖標與靜態資源
package.json           - 項目配置
.gitignore             - Git 忽略配置
LICENSE                - MIT License
README.md              - 本文檔
```

---

## 技術棧

| 組件 | 技術 | 版本 |
|------|------|------|
| 框架 | Electron | ^43.2.0 |
| 運行時 | Node.js | 22.12+ |
| 前端 | HTML5 / CSS3 / Vanilla JS | ES2022+ |
| 圖標 | Font Awesome | 6.5.0 |

---

## 安全特性

- Context Isolation — 禁用 nodeIntegration
- 沙箱隔離 — `sandbox: true`，渲染進程受限權限
- Preload 腳本 — 安全的 IPC 通信橋接；只能打開本應用下載完成的檔案（按任務 id）
- Content-Security-Policy — 只允許本地腳本，禁止頁面跳轉與新窗口
- 檔名清洗 — 過濾路徑分隔符與 Windows 保留名，防止寫出下載目錄

---

## 貢獻指南

歡迎提交 Issue 和 Pull Request！

1. Fork 本項目
2. 建立特性分支
3. 提交更改
4. 推送到分支
5. 開啟 Pull Request

---

## License

[MIT License](./LICENSE)

---

> 萬能通用下載器 SwiftDL Pro — 讓每一個文件下載變得簡單高效。⚡

Built with ❤️ by [wooyongbin3-cpu](https://github.com/wooyongbin3-cpu)
