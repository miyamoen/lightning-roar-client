const ipc = require("electron").ipcRenderer

const rootPath = "http://localhost:3000/roar"
const app = module.exports.Worker.Main.worker({ rootPath: rootPath })

app.ports.pushMyFeed.subscribe(entries => {
    console.log("subscribe pushMyFeed")
    console.log(entries)
})

app.ports.pushAllFeeds.subscribe(feeds => {
    console.log("subscribe pushAllFeeds")
    console.log(feeds)
})
