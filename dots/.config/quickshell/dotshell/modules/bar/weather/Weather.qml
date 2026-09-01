import QtQuick

import qs.modules.common
import qs.services

Item {
  id: root

  implicitWidth: weather.implicitWidth
  implicitHeight: weather.implicitHeight

  StyledText {
    id: weather
    visible: true
    anchors.centerIn: parent

    text: Weather.data?.temp

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
