import QtQuick
import QtQuick.Controls

import qs.modules.config

Slider {
  id: root

  property color fillColor: Colors.md3.on_primary
  property color posColor: Colors.md3.primary

  background: Rectangle {
    x: root.leftPadding
    y: root.topPadding + root.availableHeight / 2 - height / 2
    implicitWidth: 200
    implicitHeight: 6
    width: root.availableWidth
    height: implicitHeight
    radius: 4
    color: root.fillColor

    Rectangle {
      anchors {
        top: parent.top
        bottom: parent.bottom
      }

      width: root.visualPosition * parent.width
      radius: parent.radius
      color: root.posColor
    }
  }

  handle: Rectangle {
    x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
    y: root.topPadding + root.availableHeight / 2 - height / 2
    implicitWidth: 14
    implicitHeight: 26
    radius: 5
    color: Colors.md3.surface
    border.color: Colors.md3.primary
    border.width: 2
  }
}
