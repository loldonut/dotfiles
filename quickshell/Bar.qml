import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Scope {
  id: root
  property string time

  // TokyoNight
  property color colBg: "#222436"
  property color colText: "#c8d3f5"
  property color colTextDark: "#828bb8"
  property color colBlue: "#82aaff"
  property color colGreen: "#c3e88d"
  property color colMagenta: "#c099ff"
  property color colRed: "#ff757f"

  property string fontFamilyNerd: "Adwaita Mono"
  property string fontFamily: "Adwaita Sans"
  property int fontSize: 14

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

      implicitHeight: 35

      color: root.colBg

      RowLayout {
        id: workspace

        anchors {
          fill: parent
          margins: 5
        }

        Workspaces {}
        ActiveWindow {}
        Item { Layout.fillWidth: true }
        Bluetooth {}
        Battery {}
        ClockWidget {}
        Notification {}
      }
    }
  }

  Process {
    id: dateProc
    command: ["date"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.time = this.text
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
