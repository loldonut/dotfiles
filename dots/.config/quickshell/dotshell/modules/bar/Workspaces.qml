import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs.modules.common
import qs.modules.config

Item {
  id: root

  implicitWidth: workspaces.implicitWidth + 20

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
        id: workspaceRect

        required property HyprlandWorkspace modelData
        property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

        color: isActive ? Colors.md3.primary : Colors.md3.on_primary
        opacity: isActive ? 0.8 : 1.0

        radius: 10

        Layout.preferredWidth: isActive ? 18 : 8
        Layout.preferredHeight: isActive ? 18 : 8

        Behavior on Layout.preferredWidth {
          NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
        Behavior on Layout.preferredHeight {
          NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }

        MouseArea {
          anchors.fill: parent

          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor

          onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = "${modelData.id}" })`)
        }
      }
    }
  }
}
