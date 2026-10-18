const { app, BrowserWindow, ipcMain, shell } = require('electron');
const path = require('path');
const { DownloadManager } = require('./download-manager');

let mainWindow;
let dm;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1380, height: 850, minWidth: 900, minHeight: 640,
    title: 'SwiftDL Pro - 萬能通用下載器',
    backgroundColor: '#0a0e17',
    icon: path.join(__dirname, '../../assets/icon.png'),
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, 'preload.js')
    },
    show: false
  });
  mainWindow.loadFile(path.join(__dirname, '..', '..', 'src', 'renderer', 'index.html'));
  mainWindow.once('ready-to-show', () => mainWindow.show());
}

app.whenReady().then(() => {
  dm = new DownloadManager();
  createWindow();
  setupIpc();
  // Progress updates every second
  setInterval(() => {
    if (mainWindow && !mainWindow.isDestroyed()) {
      const downloads = dm.getDownloads();
      mainWindow.webContents.send('progress', downloads);
    }
  }, 1000);
  
  // Periodic cleanup of old completed tasks (after 5 minutes)
  setInterval(() => {
    const now = Date.now();
    for (const [id, task] of dm.tasks) {
      if (task.status === 'completed' && task.completedAt && (now - task.completedAt) > 300000) {
        dm.removeTask(id);
      }
    }
  }, 60000);
  
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

function setupIpc() {
  // Add single download
  ipcMain.handle('add-download', async (e, opts) => {
    try {
      const url = typeof opts === 'string' ? opts : opts.url;
      const savePath = opts.savePath || 'C:/Users/TUF GAMING/Downloads';
      const threads = opts.threads || 4;
      const id = await dm.addDownload(url, savePath, threads);
      return { ok: true, id };
    } catch(err) {
      return { ok: false, err: err.message };
    }
  });

  // Batch add downloads
  ipcMain.handle('batch-add', async (e, items) => {
    const results = [];
    const savePath = items[0]?.savePath || 'C:/Users/TUF GAMING/Downloads';
    const threads = items[0]?.threads || 4;
    for (const item of items) {
      try {
        const id = await dm.addDownload(item.url, savePath, threads);
        results.push({ ok: true, id, url: item.url });
      } catch(err) {
        results.push({ ok: false, err: err.message, url: item.url });
      }
    }
    return results;
  });

  // Single URL paste from clipboard
  ipcMain.handle('paste-url', async (e) => {
    try {
      const clip = require('electron').clipboard.readText();
      // Try to extract URLs from clipboard text
      const urls = clip.match(/https?:\/\/[^\s<>"']+/g);
      if (urls && urls.length > 0) {
        return { ok: true, urls };
      }
      return { ok: false, err: 'No URL found in clipboard' };
    } catch(err) {
      return { ok: false, err: err.message };
    }
  });

  // Task control
  ipcMain.handle('pause', (e, id) => { dm.pauseTask(id); return { ok: true }; });
  ipcMain.handle('resume', (e, id) => { dm.resumeTask(id); return { ok: true }; });
  ipcMain.handle('remove', (e, id) => { dm.removeTask(id); return { ok: true }; });
  ipcMain.handle('clear-completed', () => { dm.clearCompleted(); return { ok: true }; });

  // Get state
  ipcMain.handle('get-downloads', () => dm.getDownloads());
  ipcMain.handle('get-stats', () => dm.getStats());
  ipcMain.handle('get-default-path', () => 'C:/Users/TUF GAMING/Downloads');

  // Open folder with file
  ipcMain.handle('open-file', (e, fp) => {
    try { shell.openItem(fp); return { ok: true }; }
    catch(err) { return { ok: false, err: err.message }; }
  });
  ipcMain.handle('open-folder', (e, fp) => {
    try { shell.openItem(path.dirname(fp)); return { ok: true }; }
    catch(err) { return { ok: false, err: err.message }; }
  });

  // Bulk operations
  ipcMain.handle('bulk-remove', (e, ids) => {
    for (const id of ids) dm.removeTask(id);
    return { ok: true, removed: ids.length };
  });
  ipcMain.handle('bulk-pause', (e, ids) => {
    for (const id of ids) dm.pauseTask(id);
    return { ok: true, paused: ids.length };
  });
  ipcMain.handle('bulk-resume', (e, ids) => {
    for (const id of ids) dm.resumeTask(id);
    return { ok: true, resumed: ids.length };
  });
}
