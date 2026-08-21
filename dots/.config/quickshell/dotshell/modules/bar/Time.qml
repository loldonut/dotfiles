import QtQuick

import qs.modules.common
import qs.modules.config
import qs.services

StyledText {
  text: Time.getDateAndTime(Config.bar.shortTimeFormat)

  MouseArea {
    anchors.fill: parent
    onClicked: Config.bar.shortTimeFormat = !Config.bar.shortTimeFormat
  }
}
