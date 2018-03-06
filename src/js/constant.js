const path = require("path")

const resourcesPath = path.join(__dirname, "..", "..", "resources")
const iconPath = path.join(resourcesPath, "icon.png")
const rendererHtmlPath = path.join(resourcesPath, "renderer.html")
const workerHtmlPath = path.join(resourcesPath, "worker.html")

module.exports = {
    resourcesPath: resourcesPath,
    iconPath: iconPath,
    rendererHtmlPath: rendererHtmlPath,
    workerHtmlPath: workerHtmlPath
}
