const { app, BrowserWindow, clipboard, dialog, ipcMain, shell } = require('electron');
const path = require('path');
const { DownloadManager } = require('./download-manager');

const PROGRESS_INTERVAL_MS = 500;

let mainWindow;
let dm;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1380, height: 850, minWidth: 900, minHeight: 640,
    title: 'SwiftDL Pro - 萬能通用下載器',
    backgroundColor: '#0a0e17',
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      sandbox: true,
      preload: path.join(__dirname, 'preload.js'),
    },
    show: false,
  });
  mainWindow.loadFile(path.join(__dirname, '..', 'renderer', 'index.html'));
  mainWindow.once('ready-to-show', () => mainWindow.show());

  // The UI is a single local page: never navigate away or open new windows
  // inside the app. External links go to the system browser.
  mainWindow.webContents.on('will-navigate', (e) => e.preventDefault());
  mainWindow.webContents.setWindowOpenHandler(({ url }) => {
    if (/^https?:\/\//.test(url)) shell.openExternal(url);
    return { action: 'deny' };
  });
}

/** Push progress to the renderer at most every PROGRESS_INTERVAL_MS, and only when something changed. */
function startProgressFeed() {
  let dirty = true;
  dm.on('change', () => { dirty = true; });
  setInterval(() => {
    const active = dm.getStats().activeTasks > 0;
    if ((dirty || active) && mainWindow && !mainWindow.isDestroyed()) {
      dirty = false;
      mainWindow.webContents.send('progress', dm.getDownloads());
    }
  }, PROGRESS_INTERVAL_MS);
}

app.whenReady().then(() => {
  dm = new DownloadManager();
  setupIpc();
  createWindow();
  startProgressFeed();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

const defaultSaveDir = () => app.getPath('downloads');

function completedFile(id) {
  const task = dm.getTask(id);
  if (!task || task.status !== 'completed') throw new Error('Download is not finished');
  return task.filePath;
}

/** Wrap an IPC handler so errors come back as `{ ok: false, err }` instead of rejecting. */
function handle(channel, fn) {
  ipcMain.handle(channel, async (event, ...args) => {
    try {
      return { ok: true, ...(await fn(...args)) };
    } catch (err) {
      return { ok: false, err: err.message };
    }
  });
}

function setupIpc() {
  handle('add-download', ({ url, savePath, maxConcurrent } = {}) => {
    if (maxConcurrent) dm.setMaxConcurrent(maxConcurrent);
    return { id: dm.addDownload(url, savePath || defaultSaveDir()) };
  });

  ipcMain.handle('batch-add', (e, items = []) => items.map((item) => {
    try {
      if (item.maxConcurrent) dm.setMaxConcurrent(item.maxConcurrent);
      return { ok: true, url: item.url, id: dm.addDownload(item.url, item.savePath || defaultSaveDir()) };
    } catch (err) {
      return { ok: false, url: item.url, err: err.message };
    }
  }));

  handle('paste-url', () => {
    const urls = clipboard.readText().match(/https?:\/\/[^\s<>"']+/g);
    if (!urls) throw new Error('No URL found in clipboard');
    return { urls };
  });

  handle('pause', (id) => ({ changed: dm.pauseTask(id) }));
  handle('resume', (id) => ({ changed: dm.resumeTask(id) }));
  handle('remove', (id) => ({ changed: dm.removeTask(id) }));
  handle('clear-completed', () => dm.clearCompleted());
  handle('bulk-pause', (ids = []) => ({ count: ids.filter((id) => dm.pauseTask(id)).length }));
  handle('bulk-resume', (ids = []) => ({ count: ids.filter((id) => dm.resumeTask(id)).length }));
  handle('bulk-remove', (ids = []) => ({ count: ids.filter((id) => dm.removeTask(id)).length }));

  ipcMain.handle('get-downloads', () => dm.getDownloads());
  ipcMain.handle('get-stats', () => dm.getStats());
  ipcMain.handle('get-default-path', () => defaultSaveDir());
  handle('choose-dir', async (current) => {
    const { canceled, filePaths } = await dialog.showOpenDialog(mainWindow, {
      defaultPath: current || defaultSaveDir(),
      properties: ['openDirectory', 'createDirectory'],
    });
    return { dir: canceled ? null : filePaths[0] };
  });

  // Only files this app downloaded can be opened (by task id, not raw path).
  handle('open-file', async (id) => {
    const problem = await shell.openPath(completedFile(id));
    if (problem) throw new Error(problem);
  });
  handle('open-folder', (id) => shell.showItemInFolder(completedFile(id)));
}
