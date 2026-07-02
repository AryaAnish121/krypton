import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components.dock.main
import qs.components.dock.sound
import qs.modules.dock.main

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    readonly property var width_mode: {
        "audio": 325,
        "dock": dock.width + root.xpadding_dock,
        "screenshot": screenshot.width + root.xpadding_dock
    }
    property string mode: "dock"

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
        width: width_mode[mode]
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 2
        anchors.bottomMargin: 8

        DockContent {
            id: dock

            visible: mode == "dock"
            opacity: mode == "dock" ? 1 : 0
            ypadding: root.ypadding_dock
        }

        SoundContent {
            visible: (mode == "audio")
            opacity: (mode == "audio") ? 1 : 0
            onVolumeChanged: {
                root.mode = "audio";
                volumeTimer.restart();
            }

            Timer {
                id: volumeTimer

                interval: 1000
                onTriggered: {
                    root.mode = "dock";
                }
            }

        }

        Row {
            id: screenshot

            visible: (mode == "screenshot")
            spacing: 12
            height: parent.height - root.ypadding_dock
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: [{
                    "icon": "",
                    "command": "",
                    "active": false
                }, {
                    "icon": "",
                    "command": "",
                    "active": false
                }, {
                    "icon": "",
                    "command": "",
                    "active": true
                }, {
                    "icon": "",
                    "command": "",
                    "active": false
                }]

                Item {
                    height: parent.height
                    width: height
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 10
                        color: modelData.active ? '#220F46' : "transparent"

                        Text {
                            font.family: "Phosphor-Bold"
                            anchors.centerIn: parent
                            text: modelData.icon
                            font.pixelSize: 22
                            color: "#D1BCFD"
                        }

                    }

                }

            }

        }

        border {
            color: '#1ac3c3c3'
            width: 1
        }

        Behavior on width {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutQuad
            }

        }

    }

}
