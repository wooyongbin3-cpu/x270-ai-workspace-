const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const http = require('node:http');
const os = require('node:os');
const path = require('node:path');

const { DownloadManager, sanitizeFilename, filenameFromDisposition } = require('../src/main/download-manager');

const BODY = Buffer.alloc(256 * 1024, 'x');

/** Local server: /file.bin (Range aware), /redirect, /missing, /flaky (500 once). */
function startServer() {
  let flakyHits = 0;
  const server = http.createServer((req, res) => {
    if (req.url === '/redirect') {
      res.writeHead(302, { Location: '/file.bin' });
      return res.end();
    }
    if (req.url === '/missing') {
      res.writeHead(404);
      return res.end('not found');
    }
    if (req.url === '/flaky' && flakyHits++ === 0) {
      res.writeHead(500);
      return res.end();
    }
    if (req.url === '/named') {
      res.writeHead(200, { 'Content-Disposition': 'attachment; filename="report.pdf"', 'Content-Length': 3 });
      return res.end('pdf');
    }
    const range = /bytes=(\d+)-/.exec(req.headers.range || '');
    const start = range ? Number(range[1]) : 0;
    const chunk = BODY.subarray(start);
    res.writeHead(range ? 206 : 200, { 'Content-Length': chunk.length });
    res.end(chunk);
  });
  return new Promise((resolve) => server.listen(0, '127.0.0.1', () => resolve(server)));
}

function waitFor(dm, id, status) {
  return new Promise((resolve, reject) => {
    const check = () => {
      const task = dm.getTask(id);
      if (task && task.status === status) {
        dm.off('change', check);
        resolve(task);
      }
    };
    dm.on('change', check);
    check();
    setTimeout(() => reject(new Error(`timed out waiting for ${status}`)), 5000).unref();
  });
}

let server;
let base;
let dir;

test.before(async () => {
  server = await startServer();
  base = `http://127.0.0.1:${server.address().port}`;
});
test.after(() => server.close());
test.beforeEach(() => {
  dir = fs.mkdtempSync(path.join(os.tmpdir(), 'swiftdl-'));
});

test('downloads the full body to disk and leaves no .part file', async () => {
  const dm = new DownloadManager();
  const id = dm.addDownload(`${base}/file.bin`, dir);
  const task = await waitFor(dm, id, 'completed');
  assert.deepEqual(fs.readFileSync(task.filePath), BODY);
  assert.equal(fs.existsSync(task.filePath + '.part'), false);
  assert.equal(task.progress, 100);
});

test('follows redirects', async () => {
  const dm = new DownloadManager();
  const task = await waitFor(dm, dm.addDownload(`${base}/redirect`, dir), 'completed');
  assert.equal(fs.statSync(task.filePath).size, BODY.length);
});

test('never overwrites an existing file', async () => {
  fs.writeFileSync(path.join(dir, 'file.bin'), 'keep me');
  const dm = new DownloadManager();
  const task = await waitFor(dm, dm.addDownload(`${base}/file.bin`, dir), 'completed');
  assert.equal(path.basename(task.filePath), 'file (1).bin');
  assert.equal(fs.readFileSync(path.join(dir, 'file.bin'), 'utf8'), 'keep me');
});

test('uses the Content-Disposition file name', async () => {
  const dm = new DownloadManager();
  const task = await waitFor(dm, dm.addDownload(`${base}/named`, dir), 'completed');
  assert.equal(path.basename(task.filePath), 'report.pdf');
});

test('HTTP 404 is an error, not a completed file', async () => {
  const dm = new DownloadManager();
  const task = await waitFor(dm, dm.addDownload(`${base}/missing`, dir), 'error');
  assert.match(task.error, /404/);
  assert.equal(fs.readdirSync(dir).length, 0);
});

test('retries server errors', async () => {
  const dm = new DownloadManager({ retryBaseMs: 10 });
  const task = await waitFor(dm, dm.addDownload(`${base}/flaky`, dir), 'completed');
  assert.equal(task.status, 'completed');
});

test('resumes from the .part file with a Range request', async () => {
  const dm = new DownloadManager();
  const id = dm.addDownload(`${base}/file.bin`, dir);
  const task = dm.getTask(id);
  dm.pauseTask(id);
  // Simulate an interrupted transfer: half the body already on disk.
  task.filePath = path.join(dir, 'file.bin');
  fs.writeFileSync(task.partPath, BODY.subarray(0, 1000));
  assert.equal(dm.resumeTask(id), true);
  await waitFor(dm, id, 'completed');
  assert.deepEqual(fs.readFileSync(task.filePath), BODY);
});

test('respects the concurrency limit and drains the queue', async () => {
  const dm = new DownloadManager({ maxConcurrent: 1 });
  const ids = [1, 2, 3].map(() => dm.addDownload(`${base}/file.bin`, dir));
  assert.deepEqual(ids.map((id) => dm.getTask(id).status), ['downloading', 'pending', 'pending']);
  await Promise.all(ids.map((id) => waitFor(dm, id, 'completed')));
});

test('removing a completed task keeps the downloaded file', async () => {
  const dm = new DownloadManager();
  const id = dm.addDownload(`${base}/file.bin`, dir);
  const task = await waitFor(dm, id, 'completed');
  dm.clearCompleted();
  assert.equal(dm.getTask(id), undefined);
  assert.equal(fs.existsSync(task.filePath), true);
});

test('rejects non-http URLs', () => {
  const dm = new DownloadManager();
  assert.throws(() => dm.addDownload('file:///etc/passwd', dir), /http/);
  assert.throws(() => dm.addDownload('not a url', dir), /Invalid URL/);
});

test('sanitizes file names', () => {
  assert.equal(sanitizeFilename('..\\..\\evil.exe'), '_.._evil.exe');
  assert.equal(sanitizeFilename('a/b:c?.txt'), 'a_b_c_.txt');
  assert.match(sanitizeFilename('CON'), /^download_/);
  assert.match(sanitizeFilename(''), /^download_/);
  assert.equal(filenameFromDisposition("attachment; filename*=UTF-8''%E5%A0%B1%E5%91%8A.pdf"), '報告.pdf');
});

