import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

import qs.modules.common
import qs.modules.config

Rectangle {
  id: root
  required property var notif

  Timer {
    running: true
    interval: root.notif.urgency !== NotificationUrgency.Critical ? Config.notifications.timeout : Config.notifications.criticalTimeout
    onTriggered: root.notif.dismiss()
  }

  Layout.fillWidth: true
  Layout.preferredHeight: layout.implicitHeight + 20

  radius: 8
  color: Colors.md3.surface
  border.width: 2
  border.color: notif.urgency === NotificationUrgency.Critical ? "#ff0000" : Colors.md3.primary

  MouseArea {
    anchors.fill: parent
    onClicked: {
      root.notif.dismiss();
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
        Layout.margins: 4
        fillMode: Image.PreserveAspectFit
        visible: source.toString() !== ""
        source: root.notif.image || Quickshell.iconPath(root.notif.appIcon) || ""
      }

      ColumnLayout {
        Layout.fillWidth: true
        spacing: 2

        StyledText {
          Layout.fillWidth: true
          text: root.notif.summary
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
          text: root.notif.body
          font {
            pixelSize: Config.font.size + 2
          }
          wrapMode: Text.WordWrap
        }
      }
    }
  }
}
