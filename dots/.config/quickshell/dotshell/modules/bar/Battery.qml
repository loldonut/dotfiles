import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

import qs.modules.common
import qs.modules.config

StyledBarRect {
  implicitWidth: batteryText.contentWidth + 20

  StyledText {
    id: batteryText
    anchors.centerIn: parent
    Layout.alignment: Qt.AlignVCenter
    readonly property var battery: UPower.displayDevice

    color: Colors.fg

    text: {
      const isCharging = [UPowerDeviceState.Charging, UPowerDeviceState.PendingCharge].includes(battery.state)
      const state = isCharging ? "charging" : "default"

      const icons = {
        default: ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
        charging: ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]
      }

      const batteryStateIndex = Math.floor((battery.percentage * 100) / 10)
      const iconState = icons[state][batteryStateIndex]

      return `${iconState}  ${Math.floor(battery.percentage * 100)}%`
    }
  }
}
