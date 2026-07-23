import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.modules.common
import qs.modules.config

PanelWindow {
  id: dashboard

  anchors {
    top: true
    right: true
  }

  margins {
    top: 10
    right: 10
  }

  implicitWidth: row.implicitWidth + 50
  implicitHeight: 170

  visible: false
  focusable: true
  color: "transparent"

  Item {
    anchors.fill: parent
    focus: true
    Keys.onPressed: (event) => {
      if (event.key === Qt.Key_Escape) {
        dashboard.visible = false;
        event.accepted = true;
      }
    }
  }

  HyprlandFocusGrab {
    active: dashboard.visible
    windows: [dashboard]
    onCleared: dashboard.visible = false
  }

  StyledRect {
    anchors.fill: parent

    radius: 8
    border.color: Colors.inversePrimary
    border.width: 2

    RowLayout {
      id: row

      anchors.centerIn: parent
      anchors.margins: 100

      spacing: 10

      StyledRect {
        implicitWidth: 100
        implicitHeight: 100

        radius: 16
        color: Colors.onPrimary

        StyledText {
          anchors.centerIn: parent
          font.pixelSize: Config.font.size + 20

          text: ""
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(\"hyprshutdown -t 'Logging out...'\")")
        }
      }

      StyledRect {
        implicitWidth: 100
        implicitHeight: 100

        radius: 16
        color: Colors.onPrimary

        StyledText {
          anchors.centerIn: parent
          font.pixelSize: Config.font.size + 20

          text: "󰜉"
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(\"hyprshutdown -t 'Restarting...' --post-cmd 'reboot'\")")
        }
      }

      StyledRect {
        implicitWidth: 100
        implicitHeight: 100

        radius: 16
        color: Colors.onPrimary

        StyledText {
          anchors.centerIn: parent
          font.pixelSize: Config.font.size + 20

          color: "#F44336"
          text: ""
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(\"hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'\")")
        }
      }
    }
  }
}
