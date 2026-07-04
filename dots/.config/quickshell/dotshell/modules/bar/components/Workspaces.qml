import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules.config

Repeater {
  model: Hyprland.workspaces.values.slice().sort((a, b) => a.id - b.id)

  Text {
    id: workspaces
    anchors.verticalCenter: parent.verticalCenter
    required property var modelData
    property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

    text: modelData.id
    color: isActive ? Colors.fg : Colors.onPrimary
    font {
      family: Config.font.family
      pixelSize: Config.font.size - 4
      bold: true
    }

    MouseArea {
      anchors.fill: parent

      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = "${index + 1}" })`)
    }

    Behavior on color {
      ColorAnimation {
        duration: 200
        easing.type: Easing.InQuad
      }
    }

    Behavior on color {
      ColorAnimation {
        duration: 200
        easing.type: Easing.OutQuart
      }
    }
  }
}
