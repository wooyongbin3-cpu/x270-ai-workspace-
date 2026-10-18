const path = require('path');
const fs = require('fs');
const http = require('http');
const https = require('https');
const crypto = require('crypto');
const { EventEmitter } = require('events');

const MAX_REDIRECTS = 10;
const MAX_RETRIES = 3;
const RETRY_BASE_MS = 3000;
const REQUEST_TIMEOUT_MS = 120000;
const PART_SUFFIX = '.part';

const FILE_TYPES = {
  video: ['mp4', 'avi', 'mov', 'mkv', 'wmv', 'flv', 'webm', 'm4v', 'ts'],
  audio: ['mp3', 'wav', 'flac', 'aac', 'ogg', 'wma', 'opus'],
  image: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'svg', 'webp', 'ico', 'tiff'],
  archive: ['zip', 'rar', '7z', 'tar', 'gz', 'bz2', 'iso', 'xz', 'tgz'],
  document: ['pdf', 'doc', 'docx', 'txt', 'xlsx', 'ppt', 'psd', 'ai', 'odt', 'epub', 'md'],
  installer: ['exe', 'msi', 'dmg', 'deb', 'rpm', 'appimage', 'app'],
  code: ['py', 'js', 'java', 'cpp', 'c', 'rb', 'go', 'rs', 'php', 'sh', 'bat'],
  torrent: ['torrent'],
};

const ICONS = {
  video: 'fa-film', audio: 'fa-music', image: 'fa-image', document: 'fa-file-alt',
  archive: 'fa-file-archive', installer: 'fa-tools', code: 'fa-code', torrent: 'fa-magnet', other: 'fa-file',
};

function getFileType(filename) {
  const ext = path.extname(filename).toLowerCase().slice(1);
  for (const [type, exts] of Object.entries(FILE_TYPES)) {
    if (exts.includes(ext)) return type;
  }
  return 'other';
}

/** Make a URL- or header-supplied name safe to use as a single file name. */
function sanitizeFilename(name) {
  const cleaned = String(name || '')
    .replace(/[\u0000-\u001f<>:"/\\|?*]/g, '_')
    .replace(/^[.\s]+|[.\s]+$/g, '')
    .slice(0, 200);
  if (!cleaned || /^(con|prn|aux|nul|com\d|lpt\d)(\..*)?$/i.test(cleaned)) {
    return 'download_' + crypto.randomBytes(6).toString('hex');
  }
  return cleaned;
}

function filenameFromUrl(url) {
  try {
    const last = new URL(url).pathname.split('/').pop();
    return sanitizeFilename(decodeURIComponent(last));
  } catch {
    return sanitizeFilename('');
  }
}

function filenameFromDisposition(header) {
  if (!header) return null;
  const star = /filename\*\s*=\s*(?:UTF-8|utf-8)''([^;]+)/.exec(header);
  if (star) {
    try { return sanitizeFilename(decodeURIComponent(star[1].trim())); } catch { /* fall through */ }
  }
  const plain = /filename\s*=\s*"?([^";]+)"?/.exec(header);
  return plain ? sanitizeFilename(plain[1].trim()) : null;
}

/** Return `dir/name`, or `dir/name (n).ext` if that file already exists. */
function uniquePath(dir, name, taken) {
  const ext = path.extname(name);
  const base = name.slice(0, name.length - ext.length);
  for (let n = 0; ; n++) {
    const candidate = path.join(dir, n === 0 ? name : `${base} (${n})${ext}`);
    if (!taken.has(candidate) && !fs.existsSync(candidate) && !fs.existsSync(candidate + PART_SUFFIX)) {
      return candidate;
    }
  }
}

class DownloadTask {
  constructor(id, url, saveDir) {
    this.id = id;
    this.url = url;
    this.saveDir = saveDir;
    this.status = 'pending';
    this.downloadedBytes = 0;
    this.totalBytes = 0;
    this.speed = 0;
    this.error = null;
    this.createdAt = Date.now();
    this.lastUpdated = this.createdAt;
    this.startedAt = null;
    this.completedAt = null;
    this.filePath = null;
    this.filename = filenameFromUrl(url);
    this._request = null;
    this._retries = 0;
    this._retryTimer = null;
  }

  get type() { return getFileType(this.filename); }

  get progress() {
    if (this.status === 'completed') return 100;
    if (!this.totalBytes) return 0;
    return Math.min(100, (this.downloadedBytes / this.totalBytes) * 100);
  }

  get partPath() { return this.filePath + PART_SUFFIX; }

  toJSON() {
    return {
      id: this.id, url: this.url, filename: this.filename, type: this.type, icon: ICONS[this.type],
      status: this.status, progress: this.progress, downloadedBytes: this.downloadedBytes,
      totalBytes: this.totalBytes, speed: this.speed, error: this.error,
      createdAt: this.createdAt, lastUpdated: this.lastUpdated, completedAt: this.completedAt,
      filePath: this.filePath, saveDir: this.saveDir,
      elapsedTime: this.completedAt && this.startedAt ? (this.completedAt - this.startedAt) / 1000 : 0,
    };
  }
}

/**
 * Queue-based HTTP(S) download manager.
 *
 * Data is streamed into `<file>.part` and renamed on completion, so a
 * finished file is never half-written. Pause/resume and retries continue from
 * the `.part` file with a Range request when the server supports it.
 *
 * Emits `change` whenever a task's state changes.
 */
class DownloadManager extends EventEmitter {
  constructor({ maxConcurrent = 3, retryBaseMs = RETRY_BASE_MS } = {}) {
    super();
    this.tasks = new Map();
    this.nextId = 1;
    this.maxConcurrent = maxConcurrent;
    this.retryBaseMs = retryBaseMs;
    this.stats = { totalDownloads: 0, totalBytesDownloaded: 0 };
  }

  setMaxConcurrent(n) {
    const value = Number.parseInt(n, 10);
    if (Number.isInteger(value) && value > 0) {
      this.maxConcurrent = Math.min(value, 16);
      this._pump();
    }
  }

  addDownload(url, saveDir) {
    let parsed;
    try {
      parsed = new URL(url);
    } catch {
      throw new Error('Invalid URL');
    }
    if (parsed.protocol !== 'http:' && parsed.protocol !== 'https:') {
      throw new Error('Only http:// and https:// URLs are supported');
    }
    if (!saveDir) throw new Error('No save directory');
    fs.mkdirSync(saveDir, { recursive: true });
    const task = new DownloadTask(this.nextId++, parsed.href, path.resolve(saveDir));
    this.tasks.set(task.id, task);
    this._changed(task);
    this._pump();
    return task.id;
  }

  /** Start queued tasks while there are free download slots. */
  _pump() {
    let active = this._activeCount();
    for (const task of this.tasks.values()) {
      if (active >= this.maxConcurrent) break;
      if (task.status === 'pending') {
        active++;
        this._start(task);
      }
    }
  }

  _activeCount() {
    let n = 0;
    for (const t of this.tasks.values()) if (t.status === 'downloading') n++;
    return n;
  }

  _changed(task) {
    task.lastUpdated = Date.now();
    this.emit('change', task);
  }

  _start(task) {
    task.status = 'downloading';
    task.error = null;
    task.startedAt = task.startedAt || Date.now();
    this._changed(task);
    this._request(task, task.url, 0);
  }

  _request(task, url, redirects) {
    const offset = task.filePath && fs.existsSync(task.partPath) ? fs.statSync(task.partPath).size : 0;
    const mod = url.startsWith('https:') ? https : http;
    const headers = { 'User-Agent': 'SwiftDL-Pro/1.0' };
    if (offset > 0) headers.Range = `bytes=${offset}-`;

    const req = mod.get(url, { headers }, (res) => {
      if (task.status !== 'downloading') { res.resume(); return; }

      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        res.resume();
        if (redirects >= MAX_REDIRECTS) return this._fail(task, 'Too many redirects');
        return this._request(task, new URL(res.headers.location, url).href, redirects + 1);
      }
      if (res.statusCode === 416 && offset > 0) {
        // Range past the end: the .part file already holds everything.
        res.resume();
        return this._finish(task);
      }
      if (res.statusCode !== 200 && res.statusCode !== 206) {
        res.resume();
        const retryable = res.statusCode >= 500 || res.statusCode === 429;
        return this._fail(task, `HTTP ${res.statusCode}`, retryable);
      }

      if (!task.filePath) {
        const name = filenameFromDisposition(res.headers['content-disposition']) || task.filename;
        task.filePath = uniquePath(task.saveDir, name, this._takenPaths(task));
        task.filename = path.basename(task.filePath);
      }

      const resuming = res.statusCode === 206 && offset > 0;
      const length = Number.parseInt(res.headers['content-length'], 10);
      task.downloadedBytes = resuming ? offset : 0;
      task.totalBytes = Number.isNaN(length) ? 0 : task.downloadedBytes + length;

      const out = fs.createWriteStream(task.partPath, { flags: resuming ? 'a' : 'w' });
      let windowBytes = 0;
      let windowStart = Date.now();

      res.on('data', (chunk) => {
        task.downloadedBytes += chunk.length;
        windowBytes += chunk.length;
        const now = Date.now();
        if (now - windowStart >= 1000) {
          task.speed = Math.round(windowBytes / ((now - windowStart) / 1000));
          windowBytes = 0;
          windowStart = now;
        }
      });
      res.on('aborted', () => out.destroy());
      res.on('error', (err) => {
        out.destroy();
        this._fail(task, err.message, true);
      });
      out.on('error', (err) => {
        req.destroy();
        this._fail(task, err.message, false);
      });
      // 'close' (not 'finish') so the file handle is released before the
      // rename — Windows refuses to rename a file that is still open.
      out.on('close', () => {
        if (task.status !== 'downloading' || !out.writableFinished) return;
        if (task.totalBytes && task.downloadedBytes < task.totalBytes) {
          this._fail(task, 'Connection closed early', true);
        } else {
          this._finish(task);
        }
      });
      res.pipe(out);
    });

    req.setTimeout(REQUEST_TIMEOUT_MS, () => req.destroy(new Error('Download timeout')));
    req.on('error', (err) => {
      if (task.status === 'downloading') this._fail(task, err.message, true);
    });
    task._request = req;
  }

  _takenPaths(except) {
    const taken = new Set();
    for (const t of this.tasks.values()) if (t !== except && t.filePath) taken.add(t.filePath);
    return taken;
  }

  _finish(task) {
    try {
      fs.renameSync(task.partPath, task.filePath);
    } catch (err) {
      return this._fail(task, err.message, false);
    }
    task.status = 'completed';
    task.speed = 0;
    task.completedAt = Date.now();
    if (!task.totalBytes) task.totalBytes = task.downloadedBytes;
    task._request = null;
    this.stats.totalDownloads++;
    this.stats.totalBytesDownloaded += task.downloadedBytes;
    this._changed(task);
    this._pump();
  }

  _fail(task, message, retryable = true) {
    if (task.status !== 'downloading') return;
    task.speed = 0;
    task._request = null;
    if (retryable && task._retries < MAX_RETRIES) {
      task._retries++;
      task.status = 'retrying';
      task.error = `${message} — retry ${task._retries}/${MAX_RETRIES}`;
      task._retryTimer = setTimeout(() => {
        task._retryTimer = null;
        if (task.status === 'retrying') {
          task.status = 'pending';
          this._pump();
        }
      }, this.retryBaseMs * task._retries);
    } else {
      task.status = 'error';
      task.error = message;
    }
    this._changed(task);
    this._pump();
  }

  _abort(task) {
    clearTimeout(task._retryTimer);
    task._retryTimer = null;
    if (task._request) task._request.destroy();
    task._request = null;
    task.speed = 0;
  }

  pauseTask(id) {
    const task = this.tasks.get(id);
    if (!task || !['downloading', 'pending', 'retrying'].includes(task.status)) return false;
    task.status = 'paused';
    this._abort(task);
    this._changed(task);
    this._pump();
    return true;
  }

  resumeTask(id) {
    const task = this.tasks.get(id);
    if (!task || (task.status !== 'paused' && task.status !== 'error')) return false;
    task.status = 'pending';
    task.error = null;
    task._retries = 0;
    this._changed(task);
    this._pump();
    return true;
  }

  /** Forget a task. Unfinished downloads also lose their `.part` file; finished files are kept. */
  removeTask(id) {
    const task = this.tasks.get(id);
    if (!task) return false;
    const wasActive = task.status === 'downloading';
    task.status = 'removed';
    this._abort(task);
    if (task.filePath && !task.completedAt) {
      fs.rm(task.partPath, { force: true }, () => {});
    }
    this.tasks.delete(id);
    this.emit('change', task);
    if (wasActive) this._pump();
    return true;
  }

  clearCompleted() {
    for (const task of [...this.tasks.values()]) {
      if (task.status === 'completed') this.removeTask(task.id);
    }
  }

  getTask(id) {
    return this.tasks.get(id);
  }

  getStats() {
    return { ...this.stats, totalTasks: this.tasks.size, activeTasks: this._activeCount() };
  }

  getDownloads() {
    return [...this.tasks.values()].map((t) => t.toJSON());
  }
}

module.exports = { DownloadManager, DownloadTask, sanitizeFilename, filenameFromDisposition, getFileType };
