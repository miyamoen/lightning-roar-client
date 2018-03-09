const ipc = require("electron").ipcRenderer

let workerId

const app = module.exports.Renderer.Main.fullscreen()

ipc.on("allFeeds", (event, feeds) => {
    console.log("all feeda from worker")
    console.log(feeds)
    app.ports.receiveAllFeeds.send(feeds)
})

ipc.on("workerId", (event, id) => {
    if (id) workerId = id
})
