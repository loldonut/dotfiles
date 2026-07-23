import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

import qs.modules.config

PopupWindow {
  id: root

  required property Item rootItem
  property var activeMenu: null

  anchor.item: rootItem
  anchor.edges: Edges.Bottom
  anchor.gravity: Edges.Bottom
  anchor.margins.top: 30

  implicitWidth: menuRow.implicitWidth + 30
  implicitHeight: menuRow.implicitHeight + 20

  grabFocus: true

  color: "transparent"

  Rectangle {
    anchors.fill: parent

    color: Colors.onPrimary
    radius: 8
    border.color: Colors.onSecondaryFixed
    border.width: 2

    RowLayout {
      anchors.centerIn: parent
      id: menuRow
      spacing: 8

      Repeater {
        model: SystemTray.items

        delegate: MenuItem {}
      }
    }
  }
}
