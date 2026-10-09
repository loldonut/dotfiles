import QtQuick
import QtQuick.Controls

import qs.modules.common
import qs.modules.config

Button {
  id: root

  property color baseColor: Colors.md3.primary_container
  property color textColor: Colors.md3.on_primary_container
  property color hoveredColor: Colors.md3.on_primary
  property string tooltipText
  property int tooltipDelay: 1000

  ToolTip.delay: tooltipDelay
  ToolTip.visible: tooltipText !== "" ? hovered : false
  ToolTip.text: tooltipText

  background: Rectangle {
    implicitWidth: buttonText.implicitWidth + 14 * 2
    implicitHeight: 36
    color: root.hovered ? root.hoveredColor : root.baseColor
    radius: 8

    Behavior on color {
      ColorAnimation {
        duration: 150
      }
    }
  }

  contentItem: StyledText {
    id: buttonText
    text: root.text
    color: root.textColor
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onPressed: m => m.accepted = false
  }
}
