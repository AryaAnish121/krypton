import Quickshell

PanelWindow {
    property string mode

    screen: Quickshell.screens[0]
    implicitHeight: mode == "wallpaper" ? (73) : 0
    color: "transparent"

    anchors {
        bottom: true
        left: true
        right: true
    }

}
