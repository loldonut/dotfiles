import QtQuick
import QtQuick.Controls

import qs.modules.config

// TODO: Probably just use end-4's implementation of M3's switch
Switch {
  id: control

  implicitWidth: 52
  implicitHeight: 32

  property int indicatorWidth: 48
  property int indicatorHeight: 26

  indicator: Rectangle {
    implicitWidth: control.indicatorWidth
    implicitHeight: control.indicatorHeight
    x: control.leftPadding
    y: parent.height / 2 - height / 2
    radius: 13
    color: control.checked ? Colors.md3.primary : Colors.md3.surface_container_highest
    border.width: 2
    border.color: control.checked ? Colors.md3.primary : Colors.md3.outline

    Behavior on color {
      ColorAnimation {
        duration: 200
      }
    }

    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: control.checked ? 26 : 4
      x: control.checked ? parent.width - width : 0
      width: 16
      height: 16
      radius: 13
      color: control.down ? Colors.md3.outline : "#ffffff"

      Behavior on anchors.leftMargin {
        NumberAnimation {
          duration: 150
          easing.type: Easing.BezierSpline
        }
      }
      Behavior on width {
        NumberAnimation {
          duration: 150
          easing.type: Easing.BezierSpline
        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onPressed: m => m.accepted = false
  }
}
