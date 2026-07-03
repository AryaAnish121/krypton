import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components.dock.main
import qs.components.dock.selector
import qs.components.dock.sound
import qs.modules.dock.main

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    readonly property var width_mode: {
        "audio": 325,
        "dock": dock.width + root.xpadding_dock,
        "screenshot": screenshot.width + root.xpadding_dock,
        "powerMenu": powerMenu.width + root.xpadding_dock
    }
    readonly property var powerMenuOptions: [{
        "icon": "",
        "command": "lock"
    }, {
        "icon": "",
        "command": "sleep"
    }, {
        "icon": "",
        "command": "logout"
    }, {
        "icon": "",
        "command": "reboot"
    }, {
        "icon": "",
        "command": "shutdown"
    }]
    readonly property var screenshotOptions: [{
        "icon": "",
        "command": "takeScreenshot"
    }, {
        "icon": "",
        "command": "getText"
    }, {
        "icon": "",
        "command": "googleSearch"
    }, {
        "icon": "",
        "command": "colorPicker"
    }]
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
        height: 63
        y: 2
        anchors.horizontalCenter: parent.horizontalCenter

        DockContent {
            id: dock

            visible: mode == "dock"
            opacity: mode == "dock" ? 1 : 0
            ypadding: root.ypadding_dock
        }

        SoundContent {
            visible: (mode == "audio")
            opacity: (mode == "audio") ? 1 : 0
            onDockChange: {
                root.mode = "audio";
            }
            onDockClose: {
                root.mode = "dock";
            }
        }

        ListSelector {
            id: powerMenu

            selectorId: "powerMenu"
            mode: root.mode
            mainWindow: root
            ypadding: root.ypadding_dock
            options: root.powerMenuOptions
            onDockClose: {
                root.mode = "dock";
            }
            onToggleDock: {
                root.mode = root.mode == "powerMenu" ? "dock" : "powerMenu";
            }
            onSelection: (command) => {
                console.log(command);
            }
        }

        ListSelector {
            id: screenshot

            selectorId: "screenshot"
            mode: root.mode
            mainWindow: root
            ypadding: root.ypadding_dock
            options: root.screenshotOptions
            onDockClose: {
                root.mode = "dock";
            }
            onToggleDock: {
                root.mode = root.mode == "dock" ? "screenshot" : "dock";
            }
            onSelection: (command) => {
                console.log(command);
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
