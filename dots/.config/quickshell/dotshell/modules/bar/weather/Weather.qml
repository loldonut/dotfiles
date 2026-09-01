import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import qs.modules.common
import qs.modules.config
import qs.services

Item {
  id: root

  implicitWidth: weather.implicitWidth
  implicitHeight: weather.implicitHeight

  StyledText {
    id: weather
    visible: true
    anchors.centerIn: parent

    text: `${Weather.data?.tempC} °C`

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: weatherInfo.visible = !weatherInfo.visible
    }
  }

  Component.onCompleted: Weather.getData()

  WeatherInfo {
    id: weatherInfo
  }
}
