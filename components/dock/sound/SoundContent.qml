import QtQuick
import Quickshell.Services.Pipewire
import qs.modules.common

Item {
    signal dockChange()
    signal dockClose()

    Timer {
        id: volumeTimer

        interval: 1000
        onTriggered: {
            dockClose()
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property real volume: Pipewire.defaultAudioSink?.audio.volume ?? 0.0
    property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? true

    onVolumeChanged: {
        volumeTimer.restart();
        dockChange()
    }

    height: parent.height
    width: parent.width

    Row {
        spacing: 22
        anchors.centerIn: parent

        ShellText {
            text: muted ? "󰖁" : "󰕾"
            font.family: "JetBrains Mono"
            font.pixelSize: 22
            color: muted ? Colors.surfaceVariant : Colors.primary
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            radius: 5
            height: 5
            width: 200
            color: Colors.surfaceVariant

            Rectangle {
                height: parent.height
                width: volume * parent.width
                radius: 5
                color: Colors.primary

                Behavior on width {
                    NumberAnimation {
                        duration: 30
                        easing.type: Easing.InOutQuad
                    }

                }

            }

        }

    }

    Behavior on opacity {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }

    }

}
