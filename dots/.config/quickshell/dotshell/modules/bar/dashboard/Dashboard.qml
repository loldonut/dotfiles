import QtQuick
import QtQuick.Layouts
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

  implicitWidth: 370
  implicitHeight: 200

  onVisibleChanged: {
    if (visible) {
      container.forceActiveFocus();
    }
  }

  function dispatchCommand(command) {
    Hyprland.dispatch(`hl.dsp.exec_cmd('${command}')`)
  }

  StyledRect {
    id: container

    anchors.fill: parent

    radius: 8
    color: Colors.md3.surface
    border.width: 2
    border.color: Colors.md3.inverse_primary

    ColumnLayout {
      id: col
      anchors.fill: parent
      anchors.margins: 20
      spacing: 0

      RowLayout {
        MaterialSymbol {
          font.pixelSize: Config.font.size + 14
          color: Colors.md3.outline_variant
          text: "account_circle"
        }

        StyledText {
          font.pixelSize: 28
          Layout.leftMargin: -2
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
        opacity: 0.2
        color: Colors.md3.primary
      }

      RowLayout {
        id: row
        spacing: 10

        Layout.alignment: Qt.AlignHCenter

        DashboardButton {
          text: "lock"
          tooltip: "Lock"
          clickedHandler: () => {
            ShellState.locked = true;
          }
        }

        DashboardButton {
          text: "restart_alt"
          tooltip: "Restart"
          clickedHandler: () => {
            root.dispatchCommand("hyprshutdown -t 'Restarting...' --post-cmd 'reboot'");
          }
        }

        DashboardButton {
          text: "power_settings_new"
          symbolColor: "#F44336"
          tooltip: "Shutdown"
          clickedHandler: () => {
            root.dispatchCommand("hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'");
          }
        }
      }
    }
  }
}
