import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules.config

Repeater {
  model: 10

  Text {
    anchors.verticalCenter: parent.verticalCenter
    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

    id: workspaces

    text: index + 1
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
