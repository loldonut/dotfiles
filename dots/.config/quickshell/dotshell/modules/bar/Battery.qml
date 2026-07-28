import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

import qs.modules.common
import qs.modules.config

StyledBarRect {
  id: root

  readonly property var battery: UPower.displayDevice
  readonly property int batteryPercent: Math.floor(battery.percentage * 100)
  readonly property bool isCharging: [UPowerDeviceState.Charging, UPowerDeviceState.PendingCharge].includes(battery.state)

  implicitWidth: batteryRow.implicitWidth + 20

  RowLayout {
    id: batteryRow

    anchors.centerIn: parent

    MaterialSymbol {
      id: batteryText

      text: {
        const batteryIcon = Symbols.getBatteryIcon(root.batteryPercent)

        return batteryIcon
      }
    }

    MaterialSymbol {
      visible: root.isCharging

      Layout.leftMargin: -5
      size: Config.font.size - 2
      text: "bolt"
    }

    StyledText {
      text: `${root.batteryPercent}%`
    }
  }
}
