import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

import qs.modules.bar
import qs.modules.bar.components
import qs.modules.bar.components.dashboard
import qs.modules.bar.components.tray
import qs.modules.bar.components.volume
import qs.modules.bar.components.weather
import qs.modules.common
import qs.modules.config

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      margins {
        top: Config.bar.floating ? 4 : 0
        left: Config.bar.floating ? 6 : 0
        right: Config.bar.floating ? 6 : 0
      }

      color: "transparent"
      implicitHeight: Config.bar.height + 2

      Rectangle {
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
          verticalCenter: parent.verticalCenter
        }

        color: Colors.md3.on_secondary_fixed

        radius: Config.bar.floating ? 4 : 0

        RowLayout {
          anchors {
            top: parent.top
            left: parent.left
            margins: 8
            verticalCenter: parent.verticalCenter
          }
          Workspaces {}
          Separator {}
          Time {}
          Separator {}
          Weather {}
        }

        RowLayout {
          anchors {
            centerIn: parent
            margins: 8
            verticalCenter: parent.verticalCenter
          }

          ActiveWindow {}
        }

        RowLayout {
          anchors {
            top: parent.top
            right: parent.right
            margins: 8
            verticalCenter: parent.verticalCenter
          }

          spacing: 4

          Tray {}
          Connections {}
          Volume {}
          Battery {}
          PowerButton {}
        }
      }
    }
  }
}
