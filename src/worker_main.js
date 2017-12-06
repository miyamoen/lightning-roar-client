const ipc = require('electron').ipcRenderer

const rootPath = "htt://localhost:3000/roar"
const app = module.exports.Worker.Main.worker({rootPath: rootPath})
