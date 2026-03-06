import Quickshell
import Quickshell.Bluetooth
import QtQuick

// WORK IN PROGRESS
Text {
  color: "white"

  readonly property bool isEnabled: BluetoothAdapter.state
  readonly property bool isDiscovering: BluetoothAdapter.discovering

  text: ""
}
