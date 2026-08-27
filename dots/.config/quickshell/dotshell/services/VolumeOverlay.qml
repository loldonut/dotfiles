import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

import qs.modules.common
import qs.modules.config

Scope {
  id: root

  property PwNodeAudio audio: Pipewire.defaultAudioSink.audio

  PwNodeLinkTracker {
    node: Pipewire.defaultAudioSink
  }

  Connections {
    target: root.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }

    function onMutedChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  property bool shouldShowOsd: false

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.bottom: true
      margins.bottom: screen.height / 5
      exclusiveZone: 0

      implicitWidth: 350
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        Layout.fillWidth: true
        anchors.fill: parent
        radius: 10
        color: Colors.md3.surface

        border.color: Colors.md3.primary
        border.width: 2

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 15
            rightMargin: 15
          }

          MaterialSymbol {
            text: (root.audio.volume !== 0 && !root.audio.muted) ? "volume_up" : "volume_mute"
          }

          ProgressBar {
            id: control
            value: root.audio.volume
            padding: 2

            background: Rectangle {
              implicitWidth: 300
              implicitHeight: 10
              color: Colors.md3.on_primary
              radius: width / 2
            }

            contentItem: Item {
              implicitWidth: 200
              implicitHeight: 10

              Rectangle {
                width: (!audio.muted ? control.visualPosition : 0) * parent.width
                height: parent.height
                radius: width / 2
                color: Colors.md3.primary
                visible: !control.indeterminate

                Behavior on width {
                  NumberAnimation {
                    easing {
                      type: Easing.OutQuart
                      amplitude: 1
                      period: 0.5
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
