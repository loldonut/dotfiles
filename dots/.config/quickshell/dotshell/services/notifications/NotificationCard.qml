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
    running: true
    interval: card.notif.urgency !== NotificationUrgency.Critical ? Config.notifications.timeout : Config.notifications.criticalTimeout
    onTriggered: card.notif.dismiss()
  }

  Layout.fillWidth: true
  Layout.preferredHeight: layout.implicitHeight + 20

  radius: 8
  color: Colors.md3.surface
  border.width: 2
  border.color: notif.urgency === NotificationUrgency.Critical
  ? "#ff0000" : Colors.md3.primary

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
          font {
            pixelSize: Config.font.size + 2
          }
          wrapMode: Text.WordWrap
        }
      }
    }
  }
}
