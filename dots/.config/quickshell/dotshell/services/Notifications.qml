import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.modules.config

Scope {
  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      n.tracked = true
    }
  }

  PanelWindow {
    anchors {
      top: true
      right: true
    }

    margins {
      top: Config.bar.height + 8
      right: 8
    }

    implicitWidth: 380
    implicitHeight: Math.max(1, column.implicitHeight)
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    ColumnLayout {
      id: column
      width: parent.width
      spacing: 10

      Repeater {
        model: server.trackedNotifications
        delegate: Rectangle {
          id: card
          required property var modelData

          Timer {
            running: card.modelData.urgency !== NotificationUrgency.Critical
            interval: Config.notifications.timeout
            onTriggered: card.modelData.dismiss()
          }

          Layout.fillWidth: true
          Layout.preferredHeight: layout.implicitHeight + 20
          radius: 8
          color: Colors.bg
          border.width: 2
          border.color: modelData.urgency === NotificationUrgency.Critical
          ? "#ff0000" : Colors.fg

          MouseArea {
            anchors.fill: parent
            onClicked: card.modelData.dismiss()
          }

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
              source: card.modelData.image || card.modelData.appIcon || ""
            }

            ColumnLayout {
              Layout.fillWidth: true
              spacing: 2

              Text {
                Layout.fillWidth: true
                text: card.modelData.summary
                color: Colors.fg
                font.family: Config.font.family
                font.pixelSize: Config.font.size
                font.bold: true
                elide: Text.ElideRight
              }

              Text {
                Layout.fillWidth: true
                visible: text !== ""
                text: card.modelData.body
                color: Colors.fg
                font.family: Config.font.family
                font.pixelSize: Config.font.size - 2
                wrapMode: Text.WordWrap
              }
            }
          }
        }
      }
    }
  }
}
