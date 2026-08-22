import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import qs.modules.common
import qs.modules.config

StyledBarRect {
  implicitWidth: text.contentWidth + 20

  radius: 8
  topLeftRadius: 0
  bottomLeftRadius: 0

  MaterialSymbol {
    id: text
    anchors.centerIn: parent

    text: "power_settings_new"
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
