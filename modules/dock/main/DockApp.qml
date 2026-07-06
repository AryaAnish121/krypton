import QtQuick
import Quickshell
import qs.modules.dock.main

Item {
    property var appData

    height: parent.height
    width: height
    anchors.verticalCenter: parent.verticalCenter

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: Quickshell.iconPath(appData.entry?.icon)
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onClicked: (mouse) => {
            if (mouse.button == Qt.LeftButton) {
                if (appData.running)
                    appData.window.activate();
                else
                    appData.entry.execute();
            } else if (mouse.button == Qt.RightButton)
                Applist.pinApp(appData.appId);
            else if (mouse.button == Qt.MiddleButton)
                appData.entry.execute();
        }
    }

}
