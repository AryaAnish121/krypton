import QtQuick
import Quickshell
import qs.modules.dock.main

Repeater {
    model: Applist.apps

    Item {
        height: parent.height
        width: height
        anchors.verticalCenter: parent.verticalCenter

        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: Quickshell.iconPath(modelData.entry.icon)
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (modelData.running)
                    modelData.window.activate();
                else
                    modelData.entry.execute();
            }
        }

    }

}
