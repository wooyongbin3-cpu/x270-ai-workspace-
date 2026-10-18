// ===== Global State =====
const api = window.swiftDL;
let downloads = [];
let filter = 'all';
let isDark = true;
const selectedIds = new Set();

// ===== DOM helpers =====
const $ = (s) => document.querySelector(s);
const $$ = (s) => document.querySelectorAll(s);

// ===== Utilities =====
const fmtSize = (b) => {
  if (!b) return '0 B';
  const u = ['B', 'KB', 'MB', 'GB', 'TB'];
  const i = Math.min(u.length - 1, Math.floor(Math.log(b) / Math.log(1024)));
  return parseFloat((b / Math.pow(1024, i)).toFixed(1)) + ' ' + u[i];
};

const escHtml = (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

const STATUS_LABELS = { pending: '等待中', downloading: '下載中', retrying: '重試中', paused: '已暫停', completed: '已完成', error: '失敗' };
const TOAST_ICONS = { success: ['check-circle', 'green'], error: ['exclamation-circle', 'red'], warning: ['exclamation-triangle', 'yellow'] };

function toast(msg, type = 'success') {
  const [icon, colour] = TOAST_ICONS[type] || TOAST_ICONS.success;
  const t = document.createElement('div');
  t.className = 'toast' + (type === 'error' ? ' err' : type === 'warning' ? ' warn' : '');
  t.innerHTML = `<i class="fas fa-${icon}" style="color:var(--${colour})"></i><span></span>`;
  t.querySelector('span').textContent = msg;
  document.body.appendChild(t);
  setTimeout(() => { t.style.animation = 'sIn .3s ease reverse'; setTimeout(() => t.remove(), 300); }, 3000);
}

function timeAgo(ts) {
  const s = Math.floor((Date.now() - ts) / 1000);
  if (s < 60) return '剛剛';
  if (s < 3600) return Math.floor(s / 60) + ' 分鐘前';
  if (s < 86400) return Math.floor(s / 3600) + ' 小時前';
  return Math.floor(s / 86400) + ' 天前';
}

function formatElapsed(seconds) {
  if (!seconds) return '';
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  const s = Math.floor(seconds % 60);
  if (h) return `${h}:${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
  return m ? `${m}分${s}秒` : `${s}秒`;
}

function truncUrl(url) {
  try {
    const u = new URL(url);
    return u.hostname + '/…/' + u.pathname.split('/').pop().substring(0, 20);
  } catch {
    return String(url).substring(0, 50);
  }
}

// ===== Particles =====
function mkParticles() {
  const c = $('#particles');
  for (let i = 0; i < 50; i++) {
    const p = document.createElement('div');
    p.className = 'particle';
    p.style.left = Math.random() * 100 + '%';
    p.style.animationDuration = (Math.random() * 15 + 10) + 's';
    p.style.animationDelay = (Math.random() * 10) + 's';
    p.style.width = p.style.height = (Math.random() * 3 + 1) + 'px';
    c.appendChild(p);
  }
}

// ===== Theme =====
$('#themeBtn').onclick = () => {
  isDark = !isDark;
  document.documentElement.setAttribute('data-theme', isDark ? '' : 'light');
  $('#themeBtn i').className = isDark ? 'fas fa-moon' : 'fas fa-sun';
  $('#themeLabel').textContent = isDark ? '夜間' : '日間';
};

// ===== Render =====
const button = (action, id, icon, label, extra = '') =>
  `<button class="ab${extra}" data-action="${action}" data-id="${id}"><i class="fas fa-${icon}"></i> ${label}</button>`;

function renderItem(d) {
  const pct = d.progress.toFixed(1);
  const total = d.totalBytes ? fmtSize(d.totalBytes) : '?';
  const speed = d.speed > 0 ? fmtSize(d.speed) + '/s' : '--';
  const elapsed = formatElapsed(d.elapsedTime);
  const badge = d.status === 'retrying' ? 'paused' : d.status;
  const actions = [
    d.status === 'downloading' || d.status === 'pending' || d.status === 'retrying' ? button('pause', d.id, 'pause', '暫停') : '',
    d.status === 'paused' || d.status === 'error' ? button('resume', d.id, 'play', d.status === 'error' ? '重試' : '繼續') : '',
    d.status === 'completed'
      ? button('open-file', d.id, 'folder-open', '打開') + button('open-folder', d.id, 'folder', '資料夾') + button('remove', d.id, 'xmark', '移除記錄')
      : button('remove', d.id, 'trash', '刪除', ' danger'),
    button('copy', d.id, 'copy', '複製'),
  ].join('');

  return `<div class="di" data-id="${d.id}">
    <div class="dh">
      <div class="dic ${escHtml(d.type)}"><i class="fas ${escHtml(d.icon)}"></i></div>
      <div class="di-info">
        <div class="di-name" title="${escHtml(d.filePath || d.filename)}">${escHtml(d.filename)}</div>
        <div class="di-meta">
          <span><i class="fas fa-tag"></i> ${escHtml(d.type.toUpperCase())}</span>
          <span><i class="fas fa-link"></i> <small style="color:var(--text-muted)">${escHtml(truncUrl(d.url))}</small></span>
          <span><i class="fas fa-clock"></i> ${timeAgo(d.createdAt)}</span>
          ${elapsed ? `<span><i class="fas fa-hourglass-half"></i> ${elapsed}</span>` : ''}
        </div>
      </div>
      <span class="di-badge ${badge}">${STATUS_LABELS[d.status] || escHtml(d.status)}</span>
    </div>
    <div class="pbg"><div class="pbar" style="width:${pct}%"></div></div>
    <div class="pi"><span>${pct}%</span><span>${fmtSize(d.downloadedBytes)} / ${total}</span><span>${speed}</span></div>
    ${d.error ? `<div style="font-size:10px;color:var(--red);margin-bottom:8px;"><i class="fas fa-times-circle"></i> ${escHtml(d.error.substring(0, 100))}</div>` : ''}
    <div class="da">
      ${actions}
      <label style="margin-left:auto"><input type="checkbox" data-action="select" data-id="${d.id}" ${selectedIds.has(d.id) ? 'checked' : ''}></label>
    </div>
  </div>`;
}

/** Rendered items keyed by id, so unchanged rows are kept (no fade-in replay, no lost hover). */
const rows = new Map();

function render() {
  const query = $('#searchInput').value.toLowerCase().trim();
  const shown = downloads
    .filter((d) => filter === 'all' || d.status === filter || (filter === 'downloading' && d.status === 'retrying'))
    .filter((d) => !query || d.filename.toLowerCase().includes(query) || d.url.toLowerCase().includes(query));

  const list = $('#dlList');
  if (!shown.length) {
    rows.clear();
    list.innerHTML = `<div class="empty"><i class="fas fa-inbox"></i><h3>${downloads.length ? '沒有匹配的任務' : '暫無下載任務'}</h3><p>${downloads.length ? '嘗試切換過濾條件或清除搜索' : '在左側輸入下載連結或拖放連結開始下載'}</p></div>`;
    updateStats();
    return;
  }
  list.querySelector('.empty')?.remove();

  const visible = new Set();
  let prev = null;
  for (const d of shown) {
    visible.add(d.id);
    const html = renderItem(d);
    let row = rows.get(d.id);
    if (!row) {
      const tpl = document.createElement('template');
      tpl.innerHTML = html.trim();
      row = { el: tpl.content.firstElementChild, html };
      rows.set(d.id, row);
    } else if (row.html !== html) {
      // Patch the contents in place; the row element (and its animation) stays.
      const tpl = document.createElement('template');
      tpl.innerHTML = html.trim();
      row.el.replaceChildren(...tpl.content.firstElementChild.childNodes);
      row.html = html;
    }
    const expected = prev ? prev.nextSibling : list.firstChild;
    if (row.el !== expected) list.insertBefore(row.el, expected);
    prev = row.el;
  }
  for (const [id, row] of rows) {
    if (!visible.has(id)) {
      row.el.remove();
      rows.delete(id);
    }
  }
  updateStats();
}

function updateStats() {
  $('#sTotal').textContent = downloads.length;
  $('#sActive').textContent = downloads.filter((d) => d.status === 'downloading').length;
  $('#sDone').textContent = downloads.filter((d) => d.status === 'completed').length;
  $('#sSize').textContent = fmtSize(downloads.reduce((s, d) => s + d.downloadedBytes, 0));
  $('#dlSpeed').textContent = fmtSize(downloads.reduce((s, d) => s + (d.status === 'downloading' ? d.speed : 0), 0)) + '/s';
}

// ===== Download Control =====
const settings = () => ({ savePath: $('#savePath').value.trim(), maxConcurrent: parseInt($('#maxConcurrent').value, 10) });

async function addDownload(url) {
  url = (url || '').trim();
  if (!url) { toast('請輸入下載連結', 'warning'); return; }
  const { savePath, maxConcurrent } = settings();
  const res = await api.addDownload(url, savePath, maxConcurrent);
  if (res.ok) toast('已添加: ' + (url.split('/').pop() || url));
  else toast('添加失敗: ' + res.err, 'error');
}

async function addMany(urls) {
  const { savePath, maxConcurrent } = settings();
  const results = await api.batchAdd(urls.map((url) => ({ url, savePath, maxConcurrent })));
  const fail = results.filter((r) => !r.ok).length;
  toast(`完成: ${results.length - fail} 成功, ${fail} 失敗`, fail ? 'warning' : 'success');
}

const extractUrls = (text) => text.match(/https?:\/\/[^\s<>"']+/g) || [];

const ACTIONS = {
  pause: (id) => api.pause(id),
  resume: (id) => api.resume(id),
  remove: (id) => { selectedIds.delete(id); return api.remove(id); },
  'open-file': async (id) => { const r = await api.openFile(id); if (!r.ok) toast('無法打開: ' + r.err, 'error'); },
  'open-folder': async (id) => { const r = await api.openFolder(id); if (!r.ok) toast('無法打開: ' + r.err, 'error'); },
  copy: (id) => {
    const d = downloads.find((x) => x.id === id);
    if (d) navigator.clipboard.writeText(d.url).then(() => toast('連結已複製'));
  },
  select: (id) => { if (!selectedIds.delete(id)) selectedIds.add(id); },
};

// One delegated listener instead of inline onclick handlers in generated HTML.
$('#dlList').addEventListener('click', async (e) => {
  const el = e.target.closest('[data-action]');
  if (!el) return;
  await ACTIONS[el.dataset.action]?.(Number(el.dataset.id));
  refresh();
});

// ===== Events =====
$('#addBtn').onclick = () => addDownload($('#urlInput').value);
$('#urlInput').onkeydown = (e) => { if (e.key === 'Enter') addDownload($('#urlInput').value); };

$('#batchBtn').onclick = async () => {
  const urls = $('#batchInput').value.split('\n').map((u) => u.trim()).filter(Boolean);
  if (!urls.length) { toast('請輸入至少一個URL', 'warning'); return; }
  await addMany(urls);
  $('#batchInput').value = '';
};

$('#addDirBtn').onclick = async () => {
  const res = await api.chooseDir($('#savePath').value);
  if (res.ok && res.dir) $('#savePath').value = res.dir;
};

$$('.tab').forEach((t) => {
  t.onclick = () => {
    $$('.tab').forEach((x) => x.classList.remove('active'));
    t.classList.add('active');
    filter = t.dataset.f;
    render();
  };
});

$('#searchInput').oninput = render;

// Drop zone: links (from a browser) become downloads.
const dz = $('#dropZone');
dz.onclick = () => toast('從瀏覽器拖放連結到此區域即可下載', 'warning');
dz.ondragover = (e) => { e.preventDefault(); dz.classList.add('over'); };
dz.ondragleave = () => dz.classList.remove('over');
dz.ondrop = (e) => {
  e.preventDefault();
  dz.classList.remove('over');
  const urls = extractUrls(e.dataTransfer.getData('text/uri-list') || e.dataTransfer.getData('text/plain'));
  if (urls.length) addMany(urls);
  else toast('只支援拖放下載連結', 'warning');
};

async function pasteFromClipboard() {
  const res = await api.pasteUrl();
  if (res.ok) await addMany(res.urls);
  else toast('剪貼簿中沒有找到URL', 'warning');
}
$('#pasteBtn').onclick = pasteFromClipboard;

// About modal
const modal = $('#aboutModal');
$('#aboutBtn').onclick = () => modal.classList.add('active');
modal.onclick = (e) => { if (e.target === modal || e.target.closest('[data-close]')) modal.classList.remove('active'); };

document.addEventListener('keydown', (e) => {
  if (e.ctrlKey && e.key === 'v' && !e.target.closest('input,textarea')) pasteFromClipboard();
  if (e.key === 'Escape') modal.classList.remove('active');
});

// ===== Electron IPC Integration =====
function applyDownloads(data) {
  downloads = data;
  const ids = new Set(data.map((d) => d.id));
  for (const id of selectedIds) if (!ids.has(id)) selectedIds.delete(id);
  render();
}

const refresh = () => api.getDownloads().then(applyDownloads);

api.onProgress(applyDownloads);
api.getDefaultPath().then((p) => { if (!$('#savePath').value) $('#savePath').value = p; });
refresh();

// Clock
setInterval(() => {
  $('#clock').textContent = new Date().toLocaleTimeString('zh-TW', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
}, 1000);

mkParticles();
render();
