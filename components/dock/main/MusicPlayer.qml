import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.modules.dock.main

Row {
    property var dockItems

    height: parent.height
    rightPadding: dockItems == 0 ? -1 : 1.5 // fix the ghost less padding; no idea what's causing this

    Item {
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - 6
        width: height

        ClippingRectangle {
            anchors.fill: parent
            radius: 10

            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: MprisPlayers.activePlayer ? MprisPlayers.activePlayer.trackArtUrl : Quickshell.shellPath("assets/no_music.svg")
            }

        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }

    }

}
