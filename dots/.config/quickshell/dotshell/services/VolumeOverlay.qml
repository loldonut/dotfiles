import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import qs.modules.config

Scope {
  id: root

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

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

      implicitWidth: 400
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: 10
        color: Colors.bg

        border.color: Colors.fg
        border.width: 2

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 15
            rightMargin: 15
          }

          Text {
            font.bold: true
            font.family: Config.font.family
            font.pixelSize: Config.font.size + 4

            color: Colors.fg
            text: (Pipewire.defaultAudioSink?.audio.volume !== 0 && !Pipewire.defaultAudioSink?.audio.muted) ? "󰕾 " : "󰝟 "
          }

          Rectangle {
            Layout.fillWidth: true

            implicitHeight: 10
            radius: 20
            color: Colors.onPrimary

            Rectangle {
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              color: Colors.fg

              implicitWidth: parent.width * (!Pipewire.defaultAudioSink?.audio.muted ? Pipewire.defaultAudioSink?.audio.volume : 0)
              radius: parent.radius

              Behavior on implicitWidth {
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

