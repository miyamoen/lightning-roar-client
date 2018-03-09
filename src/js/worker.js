const ipc = require("electron").ipcRenderer

let rendererId
const rootPath = "http://localhost:3000/roar"

const app = module.exports.Worker.Main.worker({ rootPath: rootPath })

app.ports.pushMyFeed.subscribe(entries => {
    console.log("subscribe pushMyFeed")
    console.log(entries)
})

app.ports.pushAllFeeds.subscribe(feeds => {
    console.log("subscribe pushAllFeeds")
    console.log(feeds)
    ipc.sendTo(rendererId, "allFeeds", feeds)
})

ipc.on("rendererId", (event, id) => {
    if (id) rendererId = id
})
