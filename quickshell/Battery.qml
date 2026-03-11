import Quickshell
import Quickshell.Services.UPower
import QtQuick

Text {
  rightPadding: 5
  readonly property var battery: UPower.displayDevice

  color: root.colText
  font {
    family: root.fontFamily
    pixelSize: root.fontSize
    letterSpacing: 0.5
    bold: true
  }

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
