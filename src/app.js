const path = require('path')
const url = require('url')
const {app, BrowserWindow, shell, Menu, Tray} = require('electron')
const ipc = require('electron').ipcMain
const Elm = require('./elm_worker.js')
let mainWindow = null
let tray = null
let worker
// process.stdout.write(String(elm))

app.on('window-all-closed', function() {

})

app.on('ready', function() {
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
                mainWindow = createWindow()
                mainWindow.on('closed', function() {
                    mainWindow = null
                })
            }
        }
    })

    mainWindow = createWindow()
    mainWindow.on('closed', function() {
        mainWindow = null
    })
    // shell.openExternal('http://electron.atom.io')
})


const createWindow = () => {
    const window = new BrowserWindow({
        width: 800,
        height: 600,
        icon: path.join(__dirname, '..', 'resources', 'icon.png'),
        transparent: false,
        frame: true,
        backgroundColor: '#ccc', // 2e2c29
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
    window.webContents.openDevTools()
    return window
}