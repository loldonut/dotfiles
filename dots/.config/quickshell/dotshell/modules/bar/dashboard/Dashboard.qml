import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import qs
import qs.modules.common
import qs.modules.config
import qs.services

FocusablePanelWindow {
  id: root
  color: "transparent"
  visible: false

  anchors {
    top: true
    right: true
  }

  margins {
    top: 10
    right: 10
  }

  implicitWidth: row.implicitWidth + 50
  implicitHeight: col.implicitHeight + 50

  onVisibleChanged: {
    if (visible) {
      container.forceActiveFocus();
    }
  }

  StyledRect {
    id: container

    anchors.fill: parent

    radius: 12
    border.width: 2
    border.color: Colors.md3.inverse_primary

    ColumnLayout {
      id: col
      anchors.fill: parent
      anchors.margins: 20
      spacing: 12

      RowLayout {
        StyledText {
          font.pixelSize: 28
          text: SystemInfo.user
        }

        Item {
          Layout.fillWidth: true
        }

        ColumnLayout {
          StyledText {
            text: SystemInfo.uptime
          }
        }
      }

      Rectangle {
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: 1.5
        Layout.alignment: Qt.AlignVCenter
        Layout.leftMargin: 2
        Layout.rightMargin: 2
        opacity: 0.2
        color: Colors.md3.primary
      }

      RowLayout {
        id: row
        spacing: 10

        Layout.alignment: Qt.AlignHCenter

        DashboardButton {
          text: "lock"
          clickedHandler: () => {
            ShellState.locked = true;
          }
        }

        DashboardButton {
          text: "restart_alt"
          clickedHandler: () => {
            Hyprland.dispatch("hl.dsp.exec_cmd(\"hyprshutdown -t 'Restarting...' --post-cmd 'reboot'\")");
          }
        }

        DashboardButton {
          text: "power_settings_new"
          symbolColor: "#F44336"
          clickedHandler: () => {
            Hyprland.dispatch("hl.dsp.exec_cmd(\"hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'\")");
          }
        }
      }
    }
  }
}
