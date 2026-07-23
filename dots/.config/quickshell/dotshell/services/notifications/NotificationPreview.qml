import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

import qs.modules.common
import qs.modules.config

Rectangle {
  Layout.fillWidth: true
  Layout.preferredHeight: layout.implicitHeight + 20
  radius: 8
  color: Colors.bg
  border.width: 2
  border.color: model.urgency === NotificationUrgency.Critical
    ? "#ff0000" : Colors.onPrimary

  RowLayout {
    id: layout
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    Image {
      Layout.preferredHeight: 36
      Layout.preferredWidth: 36
      Layout.alignment: Qt.AlignTop
      fillMode: Image.PreserveAspectFit
      visible: source.toString() !== ""
      source: model.image || model.appIcon || ""
    }

    ColumnLayout {
      Layout.fillWidth: true
      spacing: 2

      StyledText {
        Layout.fillWidth: true

        font {
          pixelSize: Config.font.size + 2
          bold: true
        }

        color: Colors.fg
        text: model.summary
        elide: Text.ElideRight
      }

      StyledText {
        Layout.fillWidth: true
        visible: text !== ""

        font.pixelSize: Config.font.size + 2

        color: Colors.fg
        text: model.body
        wrapMode: Text.WordWrap
      }
    }
  }
}
