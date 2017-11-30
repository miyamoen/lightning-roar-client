const path = require('path')
const url = require('url')
const {app, BrowserWindow, shell, Menu, Tray} = require('electron')
const ipc = require('electron').ipcMain
const Elm = require('./elm_worker.js')

let mainWindow = null
let signInWindow = null
let tray = null
let worker = null

app.on('window-all-closed', () => {

})

app.on('ready', () => {
    worker = Elm.Worker.Main.worker()
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

    signInWindow = createSignInWindow()
    signInWindow.on('closed', () => {
        console.log('close nya')
        signInWindow = null
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
        pathname: path.join(__dirname, 'index.html'),
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
        pathname: path.join('localhost:3000', 'my', 'signIn'),
        protocol: 'http:',
        slashes: true
    }))

    window.webContents.on('did-get-redirect-request', (e, oldUrl, newUrl, isMain, httpResponseCode, requestMethod, referrer, headers) => {
        const token = getBouncrToken(headers)
        if (isMain && newUrl.startsWith('http://localhost:3000/') && token) {
            console.log(token)

            // workerにtokenわたす
            window.destroy()
        }
    })

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
