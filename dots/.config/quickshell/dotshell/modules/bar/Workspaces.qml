import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets

import qs.modules.common
import qs.modules.config

StyledRect {
  id: root
  implicitWidth: workspaces.implicitWidth + 20
  implicitHeight: Config.bar.height - 14

  color: "transparent"
  radius: 8

  Behavior on implicitWidth {
    SmoothedAnimation {
      duration: 200
    }
  }

  RowLayout {
    id: workspaces

    anchors.centerIn: parent
    anchors.margins: 20
    spacing: 8

    Repeater {
      model: Hyprland.workspaces.values.slice().sort((a, b) => a.id - b.id)

      StyledRect {
        Layout.alignment: Qt.AlignVCenter
        required property var modelData

        property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

        color: isActive ? Colors.md3.primary : Colors.md3.on_primary
        opacity: isActive ? 0.8 : 1.0

        implicitWidth: isActive ? 18 : 15
        implicitHeight: isActive ? 18 : 15
        radius: 10

        MouseArea {
          anchors.fill: parent

          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor

          onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = "${modelData.id}" })`)
        }

        Behavior on color {
          ColorAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
          }
        }
      }
    }
  }
}
