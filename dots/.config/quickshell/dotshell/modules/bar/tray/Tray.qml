pragma ComponentBehavior: Bound
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

    MaterialSymbol {
      anchors.centerIn: parent

      color: Colors.md3.on_primary_container
      size: Config.font.size + 14
      text: "arrow_drop_down"
    }
  }

  LazyLoader {
    id: trayLoader
    loading: true

    TrayView {
      rootItem: tray
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: trayLoader.item.visible = !trayLoader.item.visible
  }
}
