import Quickshell

PanelWindow {
    property string mode

    screen: Quickshell.screens[0]
    implicitHeight: 73
    color: "transparent"

    anchors {
        bottom: true
        left: true
        right: true
    }

}
