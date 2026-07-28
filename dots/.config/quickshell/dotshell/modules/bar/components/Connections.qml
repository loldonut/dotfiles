import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Networking

import qs.modules.common
import qs.modules.config

StyledBarRect {
  implicitWidth: connRow.implicitWidth + 20

  RowLayout {
    id: connRow
    anchors.centerIn: parent

    MaterialSymbol {
      text: {
        const network = Networking.devices.values.find((n) => n.connected)
        const isConnected = ((network !== null) && (Networking.devices.values.length > 0))

        if (!isConnected) {
          return "signal_wifi_off";
        }

        const iconState = {
          [DeviceType.Wired]: "lan",
          [DeviceType.Wifi]: "wifi"
        }

        return iconState[network.type]
      }
    }

    MaterialSymbol {
      text: "bluetooth"
    }
  }
}
