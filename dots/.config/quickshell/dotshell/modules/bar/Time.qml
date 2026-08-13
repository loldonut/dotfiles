import QtQuick
import Quickshell

import qs.modules.common
import qs.modules.config
import qs.services

StyledText {
  property bool shortFormat: Config.shortTimeFormat

  text: Time.getTime(shortFormat)

  MouseArea {
    anchors.fill: parent
    onClicked: shortFormat = !shortFormat
  }
}
