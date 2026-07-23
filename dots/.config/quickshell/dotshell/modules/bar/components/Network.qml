import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking
import Quickshell.Widgets

import qs.modules.config

RowLayout {
  Image {
    visible: false
    source: Quickshell.iconPath("network-wireless-connected")
    implicitSize: 32
  }

  Text {
    visible: false
    font {
      family: Config.font.family
      pixelSize: Config.font.size
      bold: true
    }
    color: Colors.fg

    text: {
      const network = Networking.devices.values.find((n) => n.connected)
      const isConnected = ((network !== null) && (Networking.devices.values.length > 0))

      if (!isConnected) {
        return "󰌙";
      }

      const iconState = {
        [DeviceType.Wired]: "󰌗",
        [DeviceType.Wifi]: "󰖩"
      }

      return iconState[network.type]
    }
  }

  Text {
    font {
      family: Config.font.family
      pixelSize: Config.font.size
      bold: true
    }
    color: Colors.fg

    text: "󰂯"
  }
}
