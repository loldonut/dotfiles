import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

import qs.modules.common
import qs.modules.config

Scope {
  id: root
  ListModel {
    id: history
  }

  NotificationServer {
    id: server
    property bool centerOpen: false
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      history.insert(0, {
        summary: n.summary,
        body: n.body,
        appName: n.appName,
        appIcon: n.appIcon,
        image: n.image,
        urgency: n.urgency,
        time: Qt.formatDateTime(new Date(), "HH:mm")
      });

      n.tracked = true;
    }
  }

  Timer {
    interval: Config.notifications.historyTimeout
    running: Config.notifications.clearNotifications
    repeat: true
    onTriggered: {
      if (history.count > 0)
        history.remove(history.count - 1);
    }
  }

  FocusablePanelWindow {
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
        model: server.trackedNotifications
        delegate: NotificationCard {
          required property var modelData
          notif: modelData
        }
      }
    }
  }

  NotificationCenter {
    id: ncCenter
    history: history
  }

  IpcHandler {
    target: "notifications"

    function toggle(): void {
      ncCenter.active = !ncCenter.active;
      server.centerOpen = !server.centerOpen;
    }
  }
}
