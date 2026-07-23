import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

import qs.modules.config

Item {
  id: trayItem
  required property SystemTrayItem modelData

  Layout.preferredWidth: 20
  Layout.preferredHeight: 20
  Layout.fillHeight: false
  Layout.alignment: Qt.AlignVCenter

  QsMenuOpener {
    id: menuOpener
    menu: modelData.menu
  }

  Image {
    id: trayIcon
    anchors.fill: parent

    Layout.preferredHeight: 14
    Layout.preferredWidth: 14
    Layout.alignment: Qt.AlignVCenter

    sourceSize.width: width
    sourceSize.height: height
    fillMode: Image.PreserveAspectFit
    source: modelData.icon
  }

  PopupWindow {
    id: trayMenu
    visible: false

    anchor.item: trayItem
    anchor.edges: Edges.Bottom | Edges.Left
    anchor.gravity: Edges.Bottom | Edges.Left
    anchor.margins.top: 25

    implicitWidth: 260
    implicitHeight: trayMenuCol.implicitHeight + 20

    grabFocus: true

    color: "transparent"

    Rectangle {
      anchors.fill: parent
      clip: true
      color: Colors.bg

      radius: 5
      border.width: 1
      border.color: Colors.inversePrimary

      ColumnLayout {
        id: trayMenuCol
        anchors.fill: parent
        spacing: 2
        anchors.margins: 10

        Repeater {
          model: menuOpener.children

          delegate: SubmenuItem {
            required property QsMenuEntry modelData
            entry: modelData
          }
        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    onClicked: (mouse) => {
      if (mouse.button === Qt.LeftButton) {
        modelData.activate()
      } else {
        if (root.activeMenu) {
          root.activeMenu.visible = false
          root.activeMenu = trayMenu

          trayMenu.visible = !trayMenu.visible
        } else {
          root.activeMenu = trayMenu
          trayMenu.visible = !trayMenu.visible
        }
      }
    }
  }
}
