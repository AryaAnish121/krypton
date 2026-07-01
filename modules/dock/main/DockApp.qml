import QtQuick
import Quickshell

Item {
    property var appData

    height: parent.height
    width: height
    anchors.verticalCenter: parent.verticalCenter

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: Quickshell.iconPath(appData.entry.icon)
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (appData.running)
                appData.window.activate();
            else
                appData.entry.execute();
        }
    }

}
