import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import qs.modules.config

Rectangle {
  color: Colors.onPrimary
  anchors.right: parent.right
  anchors.verticalCenter: parent.verticalCenter

  width: powerOffButton.contentWidth + 20
  height: powerOffButton.contentHeight + 4
  opacity: 1.0

  border.color: Colors.fg
  radius: 10

  Process {
    id: hyprshutdownProc
    command: ["hyprshutdown", "--post-cmd", "'shutdown now'"]
    stdout: StdioCollector {
      onStreamFinished: console.log(this.text)
    }
    running: false
  }

  Text {
    id: powerOffButton
    anchors.centerIn: parent
    font.family: Config.fontConfig.family
    font.bold: true

    color: Colors.fg

    text: ""

    ToolTip {
      parent: parent
      visible: powerOffAre.showTooltip
      text: "Power Off"
    }
  }

  MouseArea {
    id: powerOffArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    property bool showTooltip: false

    onClicked: hyprshutdownProc.running = true
    onEntered: {
      showTooltip = true
    }
  }
}
