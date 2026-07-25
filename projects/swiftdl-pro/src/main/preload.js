const { contextBridge, ipcRenderer } = require('electron');
contextBridge.exposeInMainWorld('swiftDL', {
  // Download management
  addDownload: (url, savePath, threads) => ipcRenderer.invoke('add-download', { url, savePath, threads }),
  batchAdd: (items) => ipcRenderer.invoke('batch-add', items),
  pasteUrl: () => ipcRenderer.invoke('paste-url'),
  pause: (id) => ipcRenderer.invoke('pause', id),
  resume: (id) => ipcRenderer.invoke('resume', id),
  remove: (id) => ipcRenderer.invoke('remove', id),
  clearCompleted: () => ipcRenderer.invoke('clear-completed'),
  getDownloads: () => ipcRenderer.invoke('get-downloads'),
  getStats: () => ipcRenderer.invoke('get-stats'),
  getDefaultPath: () => ipcRenderer.invoke('get-default-path'),
  openFile: (fp) => ipcRenderer.invoke('open-file', fp),
  openFolder: (fp) => ipcRenderer.invoke('open-folder', fp),

  // Bulk operations
  bulkRemove: (ids) => ipcRenderer.invoke('bulk-remove', ids),
  bulkPause: (ids) => ipcRenderer.invoke('bulk-pause', ids),
  bulkResume: (ids) => ipcRenderer.invoke('bulk-resume', ids),

  // Real-time updates
  onProgress: (cb) => {
    const handler = (e, data) => cb(data);
    ipcRenderer.on('progress', handler);
    return () => ipcRenderer.removeListener('progress', handler);
  }
});
