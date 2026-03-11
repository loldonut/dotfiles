import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
  anchors {
    fill: parent
    margins: 5
  }

  Rectangle {
    anchors.fill: parent

    color: root.colBg
    border.color: root.colTextDark
    radius: 13

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onExited: volWidget.showSlider = false
      onCanceled: volWidget.showSlider = false

      Slider {
        id: volSlider
        anchors.centerIn: parent
        from: 0
        value: audio.volume
        to: 1
        stepSize: 0.02

        background: Rectangle {
          x: volSlider.leftPadding
          y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
          implicitWidth: 150
          implicitHeight: 8
          width: volSlider.availableWidth
          height: implicitHeight
          color: root.colTextDark
          radius: 2

          Rectangle {
            width: volSlider.visualPosition * parent.width
            height: parent.height
            color: root.colBlue
            radius: 2
          }
        }

        handle: Rectangle {
          x: volSlider.leftPadding + volSlider.visualPosition * (volSlider.availableWidth - width)
          y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
          implicitWidth: 28
          implicitHeight: 28
          radius: 13
          color: root.colTextDark
          border.color: root.colBg
        }

        onMoved: audio.volume = volSlider.value
      }
    }
  }

  Text {
    anchors.fill: volWidget
    anchors.margins: 5

    color: root.colTextDark
    font {
      family: root.fontFamily
      pixelSize: 24
      letterSpacing: 0.5
      bold: true
    }

    text: "󰕾"
  }
}

