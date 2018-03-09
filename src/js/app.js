const { app, shell, session } = require("electron")
const ipc = require("electron").ipcMain

const trayCreate = require("./tray.js").create
const createWindow = require("./create_window.js")

let renderer = null
let worker = null
let signInWindow = null
let tray = null

app.on("window-all-closed", () => {})

app.on("ready", () => {
    tray = trayCreate(app, () => {
        if (renderer) {
            renderer.show()
        } else {
            createRenderer()
        }
    })

    createWorker()
    createRenderer()
    createSignInWindow()
    // shell.openExternal('http://electron.atom.io')
})

function createRenderer() {
    renderer = createWindow.renderer()
    renderer.webContents.on("did-finish-load", () => {
        renderer.webContents.send("workerId", worker.id)
    })
    worker.webContents.send("rendererId", renderer.id)

    renderer.on("closed", () => (renderer = null))
}

function createWorker() {
    worker = createWindow.worker()
    worker.webContents.openDevTools()
    worker.on("closed", () => (worker = null))

    worker.webContents.on("did-finish-load", () => {
        worker.webContents.send("rendererId", renderer.id)
    })
}

function createSignInWindow() {
    signInWindow = createWindow.signIn(renderer)
    signInWindow.on("closed", () => (signInWindow = null))

    signInWindow.webContents.on("did-finish-load", () => {
        signInWindow.webContents.session.cookies.get(
            { name: "BOUNCR_TOKEN" },
            (error, cookies) => {
                const cookie = cookies[0]
                if (cookie) {
                    session.defaultSession.cookies.set(
                        {
                            url: "http://localhost:3000",
                            name: cookie.name,
                            value: cookie.value
                        },
                        error => {
                            if (error) {
                                console.log(error)
                            }
                        }
                    )
                    signInWindow.destroy()
                }
            }
        )
    })
}
