import QtQuick

import qs.modules.common
import qs.modules.config

StyledRect {
  id: root
  required property string text
  property string command
  property var clickedHandler
  property color symbolColor: Colors.md3.primary

  implicitWidth: 50
  implicitHeight: 50

  radius: 16
  color: Colors.md3.on_primary

  MaterialSymbol {
    anchors.centerIn: parent
    font.pixelSize: Config.font.size + 20

    color: root.symbolColor
    text: root.text
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      root.clickedHandler();
    }
  }
}
