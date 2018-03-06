const { app, shell, session } = require("electron")
const ipc = require("electron").ipcMain

const trayCreate = require("./tray.js").create
const createWindow = require("./create_window.js")

let rendererWindow = null
let workerWindow = null
let signInWindow = null
let tray = null
let worker = null

app.on("window-all-closed", () => {})

app.on("ready", () => {
    tray = trayCreate(app, () => {
        if (rendererWindow) {
            rendererWindow.show()
        } else {
            rendererWindow = createWindow.renderer()
            rendererWindow.on("closed", () => (rendererWindow = null))
        }
    })

    rendererWindow = createWindow.renderer()
    rendererWindow.on("closed", () => (rendererWindow = null))

    workerWindow = createWindow.worker()
    workerWindow.webContents.openDevTools()
    workerWindow.on("closed", () => (workerWindow = null))

    signInWindow = createWindow.signIn()
    signInWindow.on("closed", () => (signInWindow = null))
    signInWindow.webContents.on("did-finish-load", () => {
        signInWindow.webContents.session.cookies.get(
            {
                name: "BOUNCR_TOKEN",
                domain: "localhost"
            },
            (error, cookies) => {
                const cookie = cookies[0]
                if (cookie) {
                    console.log(cookie)

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
    // shell.openExternal('http://electron.atom.io')
})
