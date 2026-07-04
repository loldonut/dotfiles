import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.modules.config
import qs.modules.bar
import qs.modules.bar.components
import qs.modules.bar.components.volume

Scope {
  id: root
  property string time

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: Config.bar.height

      color: Colors.bg

      RowLayout {
        id: leftLayout
        anchors {
          fill: parent
          margins: 8
        }
        spacing: 6

        Workspaces {}
        Separator {}
        Text {
          anchors.verticalCenter: parent.verticalCenter
          font.family: Config.font.family
          font.bold: true

          color: Colors.fg
          text: Time.time
        }

        Item { Layout.fillWidth: true }

        ActiveWindow {}

        Tray {}
        Separator {}
        Volume {}
        Separator {}
        Battery {}
        Separator {}
        PowerButton {}
      }
    }
  }
}
