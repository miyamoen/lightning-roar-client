const path = require('path')
const url = require('url')
const {app, BrowserWindow, shell, Menu, Tray, session} = require('electron')
const ipc = require('electron').ipcMain
const Elm = require('./elm_worker.js')


// Enables XMLHttpRequest (required by elm-lang/http) in node environment
global.XMLHttpRequest = require('xhr2').XMLHttpRequest

let mainWindow = null
let workerWindow = null
let signInWindow = null
let tray = null
let worker = null

app.on('window-all-closed', () => {

})

app.on('ready', () => {
    tray = new Tray(path.join(__dirname, '..', 'resources', 'icon.png'))
    tray.setContextMenu(Menu.buildFromTemplate([{
        label: 'Quit Lightning Roar',
        click: function() {
            app.quit()
        }
    },
    ]))
    tray.setToolTip('Lightning Roar')
    tray.on('double-click', (e, b) => {
        if (e.altKey) {
            app.quit()
        } else {
            if (mainWindow) {
                mainWindow.show()
            } else {
                mainWindow = createMainWindow()
                mainWindow.on('closed', () => {
                    mainWindow = null
                })
            }
        }
    })

    mainWindow = createMainWindow()
    mainWindow.on('closed', () => {
        mainWindow = null
    })

    workerWindow = createWorkerWindow()
    workerWindow.on('closed', () => {
        workerWindow = null
    })

    signInWindow = createSignInWindow()
    signInWindow.on('closed', () => {
        console.log('close nya')
        signInWindow = null
    })
    signInWindow.webContents.on('did-finish-load', () => {
        signInWindow.webContents.session.cookies.get({
                name: 'BOUNCR_TOKEN',
                domain: 'localhost'
            },
            (error, cookies) => {
                console.log('nuuuuuuuuuu')
                console.log(error, cookies)
                const cookie = cookies[0]
                if (cookie) {
                    cookie.hostOnly = false
                    cookie.httpOnly = false
                    cookie.session = false
                    cookie.domain = "worker"
                    // cookie.secure = true
                    cookie.url = 'file://c:/work/lightning-roar-client/src/worker.html'
                    console.log(cookie)

                    workerWindow.webContents.session.cookies.set(cookie, (er) => {
                        console.log("session set error ", er)
                    })

                    signInWindow.destroy()
                }
            })
    })
    // shell.openExternal('http://electron.atom.io')
})


const createMainWindow = () => {
    const window = new BrowserWindow({
        width: 800,
        height: 600,
        icon: path.join(__dirname, '..', 'resources', 'icon.png'),
        transparent: false,
        frame: true,
        backgroundColor: '#ccc',
        resizable: true,
        skipTaskbar: false,
        autoHideMenuBar: true,
        useContentSize: true
    })
    window.loadURL(url.format({
        pathname: path.join(__dirname, 'renderer.html'),
        protocol: 'file:',
        slashes: true
    }))
    return window
}

const createWorkerWindow = () => {
    const window = new BrowserWindow({
        // closable: false,
        // focusable: false,
        // resizable: false,
        // skipTaskbar: true,
        // transparent: true,
        width: 1000,
        height: 1000,
        // frame: false,
        // show: false,
        icon: path.join(__dirname, '..', 'resources', 'icon.png'),
        backgroundColor: '#ccc',
    })
    window.loadURL(url.format({
        pathname: path.join(__dirname, 'worker.html'),
        protocol: 'file:',
        slashes: true
    }))
    return window
}

const createSignInWindow = () => {
    const window = new BrowserWindow({
        width: 800,
        height: 600,
        icon: path.join(__dirname, '..', 'resources', 'icon.png'),
        transparent: false,
        frame: true,
        backgroundColor: '#ccc',
        resizable: true,
        skipTaskbar: false,
        autoHideMenuBar: true,
        useContentSize: true
    })
    window.loadURL(url.format({
        protocol: 'http',
        hostname: 'localhost',
        port: '3000',
        pathname: path.join('my', 'signIn'),
    }))




    return window
}

const getBouncrToken = headers => {
    const cookies = headers['set-cookie']
    if (!cookies) { return null }

    const tokenString = cookies.filter(cookie => cookie.startsWith('BOUNCR_TOKEN='))[0]
    if (!tokenString) { return null }

    const p = /^BOUNCR_TOKEN=[A-Za-z0-9-]+(?=;)/
    const res = tokenString.match(p)
    if (!res) { return null }

    return res[0].substring(13)
}
