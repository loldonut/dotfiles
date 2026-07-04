import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.modules.config

LazyLoader {
  active: volWidget.showSlider

  PanelWindow {
    anchors {
      top: true
      right: true
    }

    exclusiveZone: 0

    implicitWidth: 220
    implicitHeight: 50
    color: "transparent"

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
          rightMargin: 10
        }

        Text {
          font.bold: true
          font.family: Config.font.family
          font.pixelSize: Config.font.size + 4

          color: Colors.fg
          text: (Pipewire.defaultAudioSink?.audio.volume !== 0 && !Pipewire.defaultAudioSink?.audio.muted) ? "󰕾 " : "󰝟 "

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: audio.muted = !audio.muted
          }
        }

        Slider {
          id: volSlider
          anchors.centerIn: parent
          from: 0
          value: !audio.muted ? audio.volume : 0
          to: 1
          stepSize: 0.02

          Behavior on value {
            NumberAnimation {
              easing {
                type: Easing.OutQuart
                amplitude: 1
                period: 0.5
              }
            }
          }

          background: Rectangle {
            x: volSlider.leftPadding
            y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
            implicitWidth: 150
            implicitHeight: 8
            width: volSlider.availableWidth
            height: implicitHeight
            color: Colors.fg
            radius: 2

            Rectangle {
              width: volSlider.visualPosition * parent.width
              height: parent.height
              color: Colors.onPrimary
              radius: 2
            }
          }

          handle: Rectangle {
            x: volSlider.leftPadding + volSlider.visualPosition * (volSlider.availableWidth - width)
            y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
            implicitWidth: 28
            implicitHeight: 28
            radius: 13
            color: Colors.bg
            border.color: Colors.fg
          }

          onMoved: audio.volume = volSlider.value
        }
      }
    }
  }
}
