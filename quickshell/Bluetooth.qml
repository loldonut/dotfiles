import Quickshell
import Quickshell.Bluetooth
import Quickshell.Hyprland
import QtQuick

// WORK IN PROGRESS
Text {
  color: root.colTextDark

  readonly property bool isEnabled: BluetoothAdapter.state
  readonly property bool isDiscovering: BluetoothAdapter.discovering

  font {
    bold: true
    family: root.fontFamily
    pixelSize: root.fontSize + 2
  }

  text: "󰂯"

  MouseArea {
    anchors.fill: parent

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: Hyprland.dispatch("exec blueman-manager")
  }
}
