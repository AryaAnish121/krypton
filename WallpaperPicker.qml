import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    id: mainWindow

    property bool pickerActivated: false

    implicitWidth: 600
    implicitHeight: mainContent.height
    visible: pickerActivated
    screen: Quickshell.screens[1]

    HyprlandFocusGrab {
        active: pickerActivated
        windows: [mainWindow]
    }

    GlobalShortcut {
        name: "wallpaper"
        onPressed: {
            mainWindow.pickerActivated = !mainWindow.pickerActivated;
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width

        Column {
            id: mainContent

            width: parent.width

            Rectangle {
                width: parent.width
                height: 100

                Row {
                    spacing: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        font.family: "Phosphor-Bold"
                        text: ""
                        font.pixelSize: 22
                        color: 'red'
                    }

                    Text {
                        color: "white"
                        font.weight: 500
                        font.pixelSize: 14
                        font.family: "JetBrains Mono"
                        text: "search..."
                    }

                }

            }

        }

    }

}
