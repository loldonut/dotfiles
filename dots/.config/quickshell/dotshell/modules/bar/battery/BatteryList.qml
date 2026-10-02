import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.modules.common
import qs.modules.config

FocusablePanelWindow {
  id: root

  property list<UPowerDevice> model: UPower.devices.values.filter((device) => device.model !== '' && !device.isLaptopBattery)

  color: "transparent"

  anchors {
    top: true
    right: true
  }

  margins {
    top: 10
    right: 10
  }

  implicitWidth: 400
  implicitHeight: col.implicitHeight + 50

  Rectangle {
    anchors.fill: parent

    radius: 10
    color: Colors.md3.surface
    border.color: Colors.md3.inverse_primary
    border.width: 2

    StyledText {
      anchors.centerIn: parent
      visible: root.model.length === 0
      text: "No device detected"
    }

    ColumnLayout {
      id: col
      visible: root.model.length > 0

      anchors {
        fill: parent
        margins: 12
      }
      spacing: 0

      Repeater {
        model: root.model

        ColumnLayout {
          id: batteryItem
          required property UPowerDevice modelData

          property string deviceName: modelData.model
          property string percent: `${modelData.percentage * 100}%`
          property string timeToEmpty: modelData.timeToEmpty

          RowLayout {
            StyledText {
              text: batteryItem.deviceName
              font.bold: true
            }

            Item { Layout.fillWidth: true }

            StyledText {
              text: batteryItem.percent
              font.bold: true
            }
          }
        }
      }
    }
  }
}
