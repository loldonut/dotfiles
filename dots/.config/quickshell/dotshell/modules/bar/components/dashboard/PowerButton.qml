import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Io

import qs.modules.common
import qs.modules.config

StyledBarRect {
  implicitWidth: text.contentWidth + 20

  radius: 8
  topLeftRadius: 0
  bottomLeftRadius: 0

  StyledText {
    id: text
    anchors.centerIn: parent
    font.family: Config.font.propo

    text: "  "
  }

  Dashboard {
    id: dashboard
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: dashboard.visible = !dashboard.visible
  }
}
