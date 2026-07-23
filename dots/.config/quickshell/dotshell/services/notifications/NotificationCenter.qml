import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications

import qs.modules.common
import qs.modules.config

LazyLoader {
  id: loader
  active: false

  required property ListModel history

  PanelWindow {
    id: notificationList

    anchors {
      top: true
      right: true
    }

    implicitWidth: 500
    implicitHeight: history.count > 0 ? Math.min(centerCol.implicitHeight + 30, 700) : 700

    margins {
      top: 10
      right: 10
    }

    color: "transparent"

    HyprlandFocusGrab {
      windows: [notificationList]
      active: true
      onCleared: loader.active = false
    }

    Rectangle {
      anchors.fill: parent

      color: Colors.onSecondaryFixed
      radius: 10

      border.color: Colors.inversePrimary
      border.width: 2

      ColumnLayout {
        id: centerCol

        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        RowLayout {
          Layout.fillWidth: true

          StyledText {
            font {
              pixelSize: Config.font.size + 6
              weight: Font.Black
              variableAxes: { "wdth": 150 }
            }

            color: Colors.fg

            text: "Notifications"
          }

          Item { Layout.fillWidth: true }

          StyledText {
            visible: history.count > 0

            font {
              pixelSize: Config.font.size + 6
            }

            color: Colors.fg
            text: "clear all"

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: history.clear()
            }
          }
        }

        Rectangle {
          Layout.fillWidth: true
          color: Colors.onPrimary
          implicitHeight: 1
        }

        ColumnLayout {
          Layout.alignment: Qt.AlignHCenter
          Layout.preferredHeight: 700

          visible: history.count === 0

          StyledText {
            Layout.alignment: Qt.AlignCenter
            visible: history.count === 0

            font.pixelSize: Config.font.size + 4

            color: Colors.fg
            text: "All caught up!"
          }
        }

        ScrollView {
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true

          ColumnLayout {
            id: cardCol

            width: parent.width
            spacing: 2

            Repeater {
              model: history
              delegate: NotificationPreview {}
            }
          }
        }
      }
    }
  }
}
