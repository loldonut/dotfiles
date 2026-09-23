import QtQuick

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

    color: Colors.md3.on_primary_container
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
