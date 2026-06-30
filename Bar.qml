import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.modules

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            implicitHeight: 37
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent

                ShellText {
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    text: {
                        const win = Hyprland.activeToplevel;
                        if (!win || !win.wayland)
                            return "";

                        const entry = DesktopEntries.byId(win.wayland.appId);
                        return entry ? entry.name : win.title;
                    }
                }

                Row {
                    spacing: 28
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 25

                    SystemTray {
                    }

                    ClockWidget {
                    }

                }

                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: '#88070707'
                    }

                    GradientStop {
                        position: 1
                        color: '#00000000'
                    }

                }

            }

        }

    }

}
