import QtQuick
import QtQuick.Controls

import qs.modules.common
import qs.modules.config

Button {
  id: root

  property string command
  property var clickedHandler
  property color symbolColor: Colors.md3.on_primary_container
  property string tooltip

  ToolTip.delay: 1000
  ToolTip.visible: hovered
  ToolTip.text: tooltip

  background: Rectangle {
    implicitWidth: 80
    implicitHeight: 80
    color: root.hovered ? Colors.md3.on_primary : Colors.md3.primary_container
    radius: 8

    Behavior on color {
      ColorAnimation { duration: 150 }
    }
  }

  contentItem: MaterialSymbol {
    text: root.text
    font.pixelSize: Config.font.size + 20
    color: root.symbolColor
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clickedHandler()
  }
}
