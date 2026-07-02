import QtQuick
import qs.modules.dock.main

Row {
    property int ypadding

    spacing: 12
    height: parent.height - ypadding
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Row {
        height: parent.height
        spacing: 5

        Repeater {
            model: Applist.pinnedAppsFiltered

            DockApp {
                appData: modelData
            }

        }

    }

    Separator {
        visible: Applist.pinnedAppsFiltered.length != 0
    }

    Row {
        height: parent.height
        spacing: 5

        Repeater {
            model: Applist.unPinnedAppsFiltered

            DockApp {
                appData: modelData
            }

        }

    }

    Separator {
        visible: Applist.unPinnedAppsFiltered.length != 0
    }

    MusicPlayer {
        dockItems: Applist.pinnedAppsFiltered.length + Applist.unPinnedAppsFiltered
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }

    }

}
