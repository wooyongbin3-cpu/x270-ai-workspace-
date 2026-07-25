const path = require('path');
const fs = require('fs');
const crypto = require('crypto');

class DownloadTask {
  constructor(id, url, saveDir, numThreads) {
    this.id = id;
    this.url = url;
    this.saveDir = saveDir;
    this.numThreads = numThreads;
    this.status = 'pending';
    this.progress = 0;
    this.downloadedBytes = 0;
    this.totalBytes = 0;
    this.speed = 0;
    this.maxSpeed = 0; // 0 = unlimited
    this.filename = '';
    this.error = null;
    this.createdAt = Date.now();
    this.lastUpdated = Date.now();
    this.completedAt = null;
    this.type = 'other';
    this._request = null;
    this._retries = 0;
    this._maxRetries = 3;
    this._queuePosition = 0;
    this._elapsedTime = 0;
    this.extractFilename(url);
    this.type = this.getFileType(this.filename);
  }

  extractFilename(url) {
    try {
      const parsed = new URL(url);
      let name = decodeURIComponent(parsed.pathname.split('/').pop());
      if (!name || !name.includes('.')) {
        const ext = this.getDefaultExt(url);
        name = 'download_' + crypto.randomBytes(6).toString('hex') + ext;
      }
      this.filename = name;
    } catch (e) {
      this.filename = 'download_' + crypto.randomBytes(8).toString('hex');
    }
  }

  getDefaultExt(url) {
    const map = {'/zip':'.zip','/pdf':'.pdf','/exe':'.exe','/dmg':'.dmg','/tar.gz':'.tar.gz','/mp4':'.mp4','/mp3':'.mp3','/jpg':'.jpg','/png':'.png','/rar':'.rar','/7z':'.7z'};
    const low = url.toLowerCase();
    for (const [k,v] of Object.entries(map)) { if (low.includes(k)) return v; }
    return '.bin';
  }

  getFileType(filename) {
    const ext = path.extname(filename).toLowerCase().slice(1);
    if (['mp4','avi','mov','mkv','wmv','flv','webm','m4v','ts'].includes(ext)) return 'video';
    if (['mp3','wav','flac','aac','ogg','wma','opus'].includes(ext)) return 'audio';
    if (['jpg','jpeg','png','gif','bmp','svg','webp','ico','tiff'].includes(ext)) return 'image';
    if (['zip','rar','7z','tar','gz','bz2','iso','xz','tgz'].includes(ext)) return 'archive';
    if (['pdf','doc','docx','txt','xlsx','ppt','psd','ai','odt','epub','md'].includes(ext)) return 'document';
    if (['exe','msi','dmg','deb','rpm','appimage','app'].includes(ext)) return 'installer';
    if (['py','js','java','cpp','c','rb','go','rs','ts','php','sh','bat'].includes(ext)) return 'code';
    if (['torrent','magnet'].includes(ext)) return 'torrent';
    return 'other';
  }

  get filePath() { return path.join(this.saveDir, this.filename); }

  get remaining() {
    if (this.totalBytes === 0) return '--';
    const rem = this.totalBytes - this.downloadedBytes;
    return rem > 0 ? rem : 0;
  }

  get icon() {
    const m = {video:'fa-film',audio:'fa-music',image:'fa-image',document:'fa-file-alt',archive:'fa-file-archive',installer:'fa-tools',code:'fa-code',torrent:'fa-magnet',other:'fa-file'};
    return m[this.type] || 'fa-file';
  }

  get statusLabel() {
    const m = {pending:'等待中',downloading:'下載中',paused:'已暫停',completed:'已完成',error:'失敗'};
    return m[this.status] || this.status;
  }
}

class DownloadManager {
  constructor() {
    this.tasks = new Map();
    this.nextId = 1;
    this.stats = { totalDownloads: 0, totalBytesDownloaded: 0, totalTimeSpent: 0 };
  }

  async addDownload(url, saveDir, numThreads) {
    const task = new DownloadTask(this.nextId++, url, saveDir, numThreads || 4);
    task._queuePosition = Array.from(this.tasks.values()).filter(t => t.status === 'pending' || t.status === 'downloading').length + 1;
    if (!fs.existsSync(saveDir)) fs.mkdirSync(saveDir, { recursive: true });
    this.tasks.set(task.id, task);
    
    // Auto-start if under concurrent limit
    const activeCount = Array.from(this.tasks.values()).filter(t => t.status === 'downloading').length;
    if (activeCount < (numThreads || 4)) {
      this.startDownload(task);
    }
    return task.id;
  }

  startDownload(task) {
    if (task.status !== 'pending' && task.status !== 'paused') return;
    task.status = 'downloading';
    task._retries = 0;
    this.fetchContentLength(task);
    try {
      this.downloadViaHttp(task);
    } catch(e) {
      this.handleError(task, e.message);
    }
  }

  downloadViaHttp(task) {
    const mod = task.url.startsWith('https') ? require('https') : require('http');
    const targetPath = task.filePath;
    let resumeOffset = 0;

    // Resume from existing partial file
    if (fs.existsSync(targetPath)) {
      resumeOffset = fs.statSync(targetPath).size;
      task.downloadedBytes = resumeOffset;
    }

    const req = mod.request(task.url, {
      method: 'GET',
      headers: {
        'User-Agent': 'SwiftDL-Pro/1.0',
        ...(resumeOffset > 0 ? { 'Range': 'bytes=' + resumeOffset + '-' } : {})
      }
    }, (res) => {
      // Handle redirects
      if ([301,302,303,307,308].includes(res.statusCode)) {
        task.url = res.headers.location;
        req.destroy();
        this.fetchContentLength(task);
        this.downloadViaHttp(task);
        return;
      }

      // Update total size from content-length
      const cl = parseInt(res.headers['content-length'], 10);
      if (!isNaN(cl)) {
        task.totalBytes = resumeOffset + cl;
      } else if (task.totalBytes === 0) {
        task.totalBytes = 50 * 1024 * 1024; // fallback estimate
      }

      const ws = fs.createWriteStream(targetPath, { flags: 'a', start: resumeOffset });
      let dlv = 0, lastT = Date.now();
      let dataChunks = [];

      res.on('data', (chunk) => {
        // Speed limit check
        if (task.maxSpeed > 0) {
          dataChunks.push(chunk);
          // Simple rate limiting would go here
        }
        dlv += chunk.length;
        task.downloadedBytes += chunk.length;

        const now = Date.now();
        if (now - lastT >= 1000) {
          task.speed = Math.round(dlv / ((now - lastT) / 1000));
          dlv = 0;
          lastT = now;
        }

        if (task.totalBytes > 0) {
          task.progress = Math.min(Math.round((task.downloadedBytes / task.totalBytes) * 100), 100);
        }
        task.lastUpdated = Date.now();
      });

      res.on('end', () => {
        ws.end();
        task.stats = task.stats || {};
        task.stats.downloadedBytes = task.downloadedBytes;
        if (task.status === 'downloading' || task.status === 'paused') {
          task.status = 'completed';
          task.progress = 100;
          task.speed = 0;
          task.completedAt = Date.now();
          task._elapsedTime = (task.completedAt - task.createdAt) / 1000;
          this.stats.totalDownloads++;
          this.stats.totalBytesDownloaded += task.downloadedBytes;
        }
      });

      res.on('error', (err) => {
        ws.end();
        if (task.status === 'downloading') {
          this.handleRetry(task, err.message);
        }
      });

      ws.on('error', (err) => {
        if (task.status === 'downloading') {
          this.handleRetry(task, err.message);
        }
      });
    });

    req.on('error', (err) => {
      if (task.status === 'downloading') {
        this.handleRetry(task, err.message);
      }
    });

    req.setTimeout(120000, () => {
      req.destroy();
      if (task.status === 'downloading') {
        this.handleRetry(task, 'Download timeout');
      }
    });

    req.end();
    task._request = req;
  }

  handleRetry(task, errorMsg) {
    task._retries++;
    if (task._retries <= task._maxRetries) {
      task.error = errorMsg;
      task.status = 'error';
      // Wait then retry
      setTimeout(() => {
        if (task.status === 'error') {
          this.startDownload(task);
        }
      }, 3000 * task._retries);
    } else {
      task.error = errorMsg + ' (max retries: ' + task._maxRetries + ')';
      task.status = 'error';
      task.speed = 0;
      try { fs.unlinkSync(task.filePath); } catch(e) {}
    }
  }

  handleError(task, msg) {
    task.status = 'error';
    task.error = msg;
    task.speed = 0;
  }

  fetchContentLength(task) {
    const mod = task.url.startsWith('https') ? require('https') : require('http');
    const req = mod.request(task.url, { method: 'HEAD', timeout: 5000 }, (res) => {
      const cl = res.headers['content-length'];
      if (cl) task.totalBytes = parseInt(cl, 10);
      res.resume();
    });
    req.on('error', () => {});
    req.end();
  }

  pauseTask(taskId) {
    const task = this.tasks.get(taskId);
    if (task && task.status === 'downloading') {
      task.status = 'paused';
      task.speed = 0;
      if (task._request) try { task._request.destroy(); } catch(e) {}
    }
  }

  resumeTask(taskId) {
    const task = this.tasks.get(taskId);
    if (task && (task.status === 'paused' || task.status === 'error')) {
      task.status = 'downloading';
      task.error = null;
      task._retries = 0;
      this.startDownload(task);
    }
  }

  removeTask(taskId) {
    const task = this.tasks.get(taskId);
    if (task) {
      if (task._request) try { task._request.destroy(); } catch(e) {}
      try { if (fs.existsSync(task.filePath)) fs.unlinkSync(task.filePath); } catch(e) {}
      this.tasks.delete(taskId);
    }
  }

  clearCompleted() {
    for (const [id] of this.tasks) {
      const t = this.tasks.get(id);
      if (t.status === 'completed') this.removeTask(id);
    }
  }

  setSpeedLimit(taskId, limit) {
    const task = this.tasks.get(taskId);
    if (task) { task.maxSpeed = limit; }
  }

  getStats() {
    return { ...this.stats, totalTasks: this.tasks.size, activeTasks: Array.from(this.tasks.values()).filter(t => t.status === 'downloading').length };
  }

  getDownloads() {
    return Array.from(this.tasks.values()).map(t => ({
      id: t.id, url: t.url, filename: t.filename, type: t.type, icon: t.icon,
      status: t.status, progress: t.progress, downloadedBytes: t.downloadedBytes,
      totalBytes: t.totalBytes, speed: t.speed, error: t.error,
      createdAt: t.createdAt, lastUpdated: t.lastUpdated, completedAt: t.completedAt,
      filePath: t.filePath, saveDir: t.saveDir, maxSpeed: t.maxSpeed,
      elapsedTime: t._elapsedTime || 0
    }));
  }
}

module.exports = { DownloadManager, DownloadTask };
