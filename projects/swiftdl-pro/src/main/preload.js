const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('swiftDL', {
  // Download management
  addDownload: (url, savePath, maxConcurrent) => ipcRenderer.invoke('add-download', { url, savePath, maxConcurrent }),
  batchAdd: (items) => ipcRenderer.invoke('batch-add', items),
  pasteUrl: () => ipcRenderer.invoke('paste-url'),
  pause: (id) => ipcRenderer.invoke('pause', id),
  resume: (id) => ipcRenderer.invoke('resume', id),
  remove: (id) => ipcRenderer.invoke('remove', id),
  clearCompleted: () => ipcRenderer.invoke('clear-completed'),
  getDownloads: () => ipcRenderer.invoke('get-downloads'),
  getStats: () => ipcRenderer.invoke('get-stats'),
  getDefaultPath: () => ipcRenderer.invoke('get-default-path'),
  chooseDir: (current) => ipcRenderer.invoke('choose-dir', current),
  openFile: (id) => ipcRenderer.invoke('open-file', id),
  openFolder: (id) => ipcRenderer.invoke('open-folder', id),

  // Bulk operations
  bulkRemove: (ids) => ipcRenderer.invoke('bulk-remove', ids),
  bulkPause: (ids) => ipcRenderer.invoke('bulk-pause', ids),
  bulkResume: (ids) => ipcRenderer.invoke('bulk-resume', ids),

  // Real-time updates
  onProgress: (cb) => {
    const handler = (e, data) => cb(data);
    ipcRenderer.on('progress', handler);
    return () => ipcRenderer.removeListener('progress', handler);
  },
});
