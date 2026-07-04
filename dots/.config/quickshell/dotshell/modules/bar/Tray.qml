import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

import qs.modules.config

RowLayout {
  anchors.verticalCenter: parent.verticalCenter

  Repeater {
    model: SystemTray.items

    delegate: Image {
      required property SystemTrayItem modelData
      Layout.preferredHeight: 14
      Layout.preferredWidth: 14
      Layout.alignment: Qt.AlignVCenter
      fillMode: Image.PreserveAspectFit
      source: modelData.icon

      PanelWindow {
        id: trayMenu
        anchors {
          top: true
          right: true
        }
        visible: false
        color: "transparent"
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: (mouse) => {
          if (mouse.button === Qt.LeftButton) {
            modelData.activate()
          } else {
            if (trayMenu.visible) {
              trayMenu.visible = false
            }

            trayMenu.visible = true
            modelData.menu.open()
          }
        }
      }
    }
  }
}
