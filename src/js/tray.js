const { Tray, Menu } = require("electron")
const { iconPath } = require("./constant.js")

const create = (app, onDoubleClick) => {
    const tray = new Tray(iconPath)
    tray.setToolTip("Lightning Roar")

    tray.setContextMenu(
        Menu.buildFromTemplate([
            {
                label: "Quit Lightning Roar",
                click: () => app.quit()
            }
        ])
    )

    tray.on("double-click", (e, b) => {
        if (e.altKey) {
            app.quit()
        } else {
            onDoubleClick()
        }
    })

    return tray
}

module.exports = { create: create }
