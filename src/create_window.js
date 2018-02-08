const url = require("url")
const { BrowserWindow } = require("electron")

const { rendererHtmlPath, workerHtmlPath } = require("./constant.js")

const renderer = () => {
  const window = new BrowserWindow({
    width: 800,
    height: 600,
    icon: iconPath,
    transparent: false,
    frame: true,
    backgroundColor: "#ccc",
    resizable: true,
    skipTaskbar: false,
    autoHideMenuBar: true,
    useContentSize: true
  })
  window.loadURL(
    url.format({
      pathname: rendererHtmlPath,
      protocol: "file:",
      slashes: true
    })
  )
  return window
}

const worker = () => {
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
    backgroundColor: "#ccc"
  })
  window.loadURL(
    url.format({
      pathname: workerHtmlPath,
      protocol: "file:",
      slashes: true
    })
  )
  return window
}

const signIn = () => {
  const window = new BrowserWindow({
    width: 800,
    height: 600,
    icon: iconPath,
    transparent: false,
    frame: true,
    backgroundColor: "#ccc",
    resizable: true,
    skipTaskbar: false,
    autoHideMenuBar: true,
    useContentSize: true
  })
  window.loadURL(
    url.format({
      protocol: "http",
      hostname: "localhost",
      port: "3000",
      pathname: path.join("my", "signIn")
    })
  )
  return window
}

module.exports = {
  renderer: renderer,
  worker: worker,
  signIn: signIn
}
