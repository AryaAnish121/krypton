import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    property PanelWindow mainWindow
    property string mode

    signal toggleDock()
    signal dockClose()

    focus: mode == "wallpaper"
    Keys.onPressed: (event) => {
        console.log("meowww");
        if (event.key == Qt.Key_Escape)
            dockClose();

    }

    HyprlandFocusGrab {
        active: mode == "wallpaper"
        windows: [mainWindow]
    }

    GlobalShortcut {
        name: "wallpaper"
        onPressed: {
            toggleDock();
        }
    }

    Text {
        color: "white"
        font.bold: true
        text: "meow"
    }

}
