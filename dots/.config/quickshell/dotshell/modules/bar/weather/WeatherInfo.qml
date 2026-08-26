import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.modules.config
import qs.services

PopupWindow {
  id: weatherInfo
  visible: false

  anchor {
    edges: Edges.Bottom
    gravity: Edges.Bottom
    item: root
    margins.top: Config.bar.height - 8
  }

  grabFocus: true
  implicitWidth: weatherCard.implicitWidth + 150
  implicitHeight: weatherCard.implicitHeight + 20

  color: "transparent"

  StyledRect {
    id: weatherRect

    anchors.fill: parent

    radius: 8
    border.color: Colors.md3.inverse_primary
    border.width: 2

    RowLayout {
      id: weatherCard

      anchors {
        fill: parent
        margins: 12
        leftMargin: 20
        rightMargin: 20
      }

      spacing: 20

      StyledText {
        font.pixelSize: Config.font.size + 24
        text: `${Weather.data?.tempC} °C`
      }

      ColumnLayout {
        StyledText {
          text: `Humidity: ${Weather.data?.humidity}%`
          opacity: 0.8
        }

        StyledText {
          text: `Wind: ${Weather.data?.windspeedKmph} km/h`
          opacity: 0.8
        }

        StyledText {
          text: `Pressure: ${Weather.data?.pressure}hPa`
          opacity: 0.8
        }
      }

      Item {
        Layout.fillWidth: true
      }

      ColumnLayout {
        StyledText {
          font.pixelSize: Config.font.size + 6
          Layout.alignment: Qt.AlignRight
          text: "Weather"
        }

        StyledText {
          Layout.alignment: Qt.AlignRight
          font.pixelSize: Config.font.size + 4
          text: Weather.data?.observationTime
        }

        StyledText {
          Layout.alignment: Qt.AlignRight
          font.pixelSize: Config.font.size + 4
          text: Weather.data?.desc
        }
      }
    }
  }
}
