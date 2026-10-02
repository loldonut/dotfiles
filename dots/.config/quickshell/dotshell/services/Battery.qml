pragma Singleton
import Quickshell
import Quickshell.Services.UPower

Singleton {
  readonly property bool available: UPower.displayDevice.isLaptopBattery
  readonly property var device: UPower.displayDevice
  readonly property var rawPercent: device.percentage ?? 1
  readonly property int percent: Math.floor(rawPercent * 100)
  readonly property bool isCharging: [UPowerDeviceState.Charging, UPowerDeviceState.PendingCharge].includes(device.state)
}
