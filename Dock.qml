import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components.dock.main
import qs.components.dock.selector
import qs.components.dock.sound
import qs.components.dock.wallpaper
import qs.modules.dock.main

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    readonly property var width_mode: {
        "audio": 325,
        "dock": dock.width + root.xpadding_dock,
        "screenshot": screenshot.width + root.xpadding_dock,
        "powerMenu": powerMenu.width + root.xpadding_dock,
        "wallpaper": 750
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
    property string mode

    signal switchMode(string switchTo)
    signal closeDockMain()

    screen: Quickshell.screens[0]
    implicitHeight: (mode == "wallpaper") ? 613 : 73
    color: "transparent"
    WlrLayershell.namespace: "qsdock"
    WlrLayershell.layer: (mode == "wallpaper") ? WlrLayer.Overlay : WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore

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
            onDockChange: {
                switchMode("audio");
            }
            onDockClose: {
                closeDockMain();
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
                closeDockMain();
            }
            onToggleDock: {
                switchMode("powerMenu");
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
                closeDockMain();
            }
            onToggleDock: {
                switchMode("screenshot");
            }
            onSelection: (command) => {
                console.log(command);
            }
        }

        WallpaperSelector {
            mainWindow: root
            mode: root.mode
            visible: (mode == "wallpaper")
            opacity: (mode == "wallpaper") ? 1 : 0
            onToggleDock: {
                switchMode("wallpaper");
            }
            onDockClose: {
                closeDockMain();
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
