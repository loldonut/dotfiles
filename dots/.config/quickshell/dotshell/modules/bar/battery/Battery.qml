import QtQuick
import QtQuick.Layouts

import qs.modules.common
import qs.modules.config
import qs.services

StyledBarRect {
  id: root

  visible: Battery.available

  implicitWidth: batteryRow.implicitWidth + 20

  RowLayout {
    id: batteryRow

    anchors.centerIn: parent

    MaterialSymbol {
      id: batteryText
      color: Colors.md3.on_primary_container

      text: {
        const batteryIcon = Symbols.getBatteryIcon(Battery.percent);

        return batteryIcon;
      }
    }

    MaterialSymbol {
      visible: Battery.isCharging
      color: Colors.md3.on_primary_container

      Layout.leftMargin: -5
      size: Config.font.iconSize
      text: "bolt"
    }

    StyledText {
      color: Colors.md3.on_primary_container
      text: `${Battery.percent}%`
    }
  }

  BatteryList {
    id: batteryList
    visible: false
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: batteryList.visible = !batteryList.visible
  }
}
