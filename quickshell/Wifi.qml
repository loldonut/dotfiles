import Quickshell
import Quickshell.Networking
import QtQuick

Text {
  readonly property var network: Networking.devices.values[0]
  readonly property bool isUsingWifi: network.type === 0
  color: root.colTextDark
  font {
    family: root.fontFamily
    pixelSize: root.fontSize
    bold: true
  }
  text: isUsingWifi ? "󰤨" : `󰌗`

  MouseArea {
    anchors.fill: parent

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: console.log(network.type)
  }
}
