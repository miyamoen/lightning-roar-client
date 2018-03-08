const ipc = require("electron").ipcRenderer

const app = module.exports.Renderer.Main.fullscreen()

app.ports.receiveAllFeeds.send();
