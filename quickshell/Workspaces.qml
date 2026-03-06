import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Repeater {
  model: Hyprland.workspaces.values.length

  Rectangle {
    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

    id: wsRect

    width: workspaces.contentWidth + 30
    height: workspaces.contentHeight + 4
    opacity: 1.0

    border.color: isActive ? root.colBlue : "#3b4261"
    border.width: 1.2
    radius: 10
    color: isActive ? "#2f334d" : "#191B29"

    Text {
      id: workspaces

      anchors.centerIn: parent

      text: index + 1
      color: isActive ? root.colBlue : root.colTextDark
      font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
      }

      Behavior on color {
        ColorAnimation {
          duration: 400
          easing.type: Easing.InQuad
        }
      }
    }

    Behavior on border.color {
      ColorAnimation {
        duration: 400
        easing.type: Easing.OutQuart
      }
    }

    MouseArea {
      anchors.fill: parent

      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      onClicked: Hyprland.dispatch("workspace " + (index + 1))
    }
  }
}
