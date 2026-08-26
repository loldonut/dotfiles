import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.config
import qs.services.notifications

PanelWindow {
  anchors {
    top: true
    right: true
  }

  margins {
    top: Config.bar.height + 14
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
      model: Notifications.server.trackedNotifications
      delegate: NotificationCard {
        required property var modelData
        notif: modelData
      }
    }
  }
}
