import Quickshell
import Quickshell.Services.UPower
import QtQuick

import qs.modules.config

Text {
  anchors.verticalCenter: parent.verticalCenter
  rightPadding: 5
  readonly property var battery: UPower.displayDevice

  font.family: Config.font.family
  font.bold: true

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

    return `${iconState} ${Math.floor(battery.percentage * 100)}%`
  }
}
