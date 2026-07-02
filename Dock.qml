import QtQuick
import Quickshell
// added
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.components.dock.main
import qs.components.dock.sound
import qs.modules.common

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    readonly property var width_mode: {
        "audio": 325
    }
    property string mode: "dock"

    screen: Quickshell.screens[0]
    implicitHeight: 73
    color: "transparent"
    WlrLayershell.namespace: "qsdock"

    readonly property list<HyprlandWorkspace> workspaceList: Hyprland.workspaces.values

    anchors {
        bottom: true
        left: true
        right: true
    }

    Timer {
        id: volumeTimer

        interval: 1000
        onTriggered: {
            root.mode = "dock";
        }
    }

    Rectangle {
        id: meow

        color: '#21000000'
        radius: 10
        width: {
            if (mode != "dock")
                return width_mode[mode];

            return dock.width + root.xpadding_dock;
        }
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 2
        anchors.bottomMargin: 8

        DockContent {
            id: dock

            visible: mode == "dock"
            opacity: mode == "dock" ? 1 : 0
        }

        SoundContent {
            // disabled for testing
            // onVolumeChanged: {
            //     root.mode = "audio";
            //     volumeTimer.restart();
            // }

            visible: (mode == "audio")
            opacity: (mode == "audio") ? 1 : 0
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
