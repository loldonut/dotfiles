import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.modules.config

Item {
  id: tray
  Layout.alignment: Qt.AlignVCenter
  Layout.preferredWidth: 30
  Layout.preferredHeight: Config.bar.height - 14

  StyledBarRect {
    anchors.fill: parent

    radius: 8
    topRightRadius: 0
    bottomRightRadius: 0

    Text {
      anchors.centerIn: parent

      color: Colors.fg
      text: ""
    }
  }

  TrayView {
    id: trayView
    rootItem: tray
  }

  MouseArea {
    anchors.fill: parent
    onClicked: trayView.visible = !trayView.visible
  }
}
