import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 25

    Repeater {
        model: SystemTray.items

        Item {
            id: trayItem

            width: 22
            height: 22

            QsMenuAnchor {
                id: trayMenuAnchor

                anchor.item: trayItem
                menu: modelData.menu
                anchor.edges: Edges.Bottom | Edges.Right
            }

            Image {
                anchors.fill: parent
                source: modelData.icon
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: (modelData.hasMenu) ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: function(mouse) {
                    if (mouse.button === Qt.RightButton)
                        trayMenuAnchor.open();
                    else
                        modelData.activate();
                }
            }

        }

    }

}
