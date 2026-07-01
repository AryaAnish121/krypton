import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import Quickshell.Wayland
import Quickshell.Widgets
import qs.modules

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15

    screen: Quickshell.screens[0]
    implicitHeight: 73
    color: "transparent"
    WlrLayershell.namespace: "qsdock"

    anchors {
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        color: '#21000000'
        radius: 10
        width: dock.width + root.xpadding_dock
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 2
        anchors.bottomMargin: 8

        Row {
            id: dock

            spacing: 12
            height: parent.height - root.ypadding_dock
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                id: dockIcons

                height: parent.height
                spacing: 8

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

            }

            Rectangle {
                width: 2
                color: '#a4808080'
                height: parent.height * 0.3
                anchors.verticalCenter: parent.verticalCenter
                radius: 5
            }

            Row {
                height: parent.height
                rightPadding: 0.8 // fix the ghost less padding; no idea what's causing this

                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height - 7
                    width: height

                    ClippingRectangle {
                        anchors.fill: parent
                        radius: 10

                        Image {
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            source: MprisPlayers.activePlayer ? MprisPlayers.activePlayer.trackArtUrl : "assets/no_music.svg"
                        }

                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }

                }

            }

        }

        border {
            color: '#1ac3c3c3'
            width: 1
        }

    }

}
