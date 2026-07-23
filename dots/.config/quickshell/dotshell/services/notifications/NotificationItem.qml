import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

import qs.modules.common
import qs.modules.config

Rectangle {
  id: card
  required property var notif

  Timer {
    running: card.notif.urgency !== NotificationUrgency.Critical
    interval: Config.notifications.timeout
    onTriggered: card.notif.dismiss()
  }

  Layout.fillWidth: true
  Layout.preferredHeight: layout.implicitHeight + 20

  radius: 8
  color: Colors.bg
  border.width: 2
  border.color: notif.urgency === NotificationUrgency.Critical
  ? "#ff0000" : Colors.fg

  MouseArea {
    anchors.fill: parent
    onClicked: {
      card.notif.dismiss()
    }
  }

  ColumnLayout {
    id: layout
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    RowLayout {
      Image {
        Layout.preferredHeight: 36
        Layout.preferredWidth: 36
        Layout.alignment: Qt.AlignTop
        fillMode: Image.PreserveAspectFit
        visible: source.toString() !== ""
        source: card.notif.image || card.notif.appIcon || ""
      }

      ColumnLayout {
        Layout.fillWidth: true
        spacing: 2

        StyledText {
          Layout.fillWidth: true
          text: card.notif.summary
          color: Colors.fg
          font {
            family: Config.font.family
            pixelSize: Config.font.size + 2
            bold: true
          }
          elide: Text.ElideRight
        }

        StyledText {
          Layout.fillWidth: true
          visible: text !== ""
          text: card.notif.body
          color: Colors.fg
          font {
            pixelSize: Config.font.size + 2
          }
          wrapMode: Text.WordWrap
        }
      }
    }
  }
}
