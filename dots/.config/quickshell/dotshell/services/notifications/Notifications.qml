pragma Singleton
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

import qs.modules.common
import qs.modules.config

Singleton {
  id: root

  ListModel {
    id: history
  }

  property alias history: history
  property alias server: server

  NotificationServer {
    id: server

    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      n.tracked = true;
      history.insert(0, {
        summary: n.summary,
        body: n.body,
        appName: n.appName,
        appIcon: n.appIcon,
        image: n.image,
        urgency: n.urgency,
        time: Qt.formatDateTime(new Date(), "HH:mm")
      });
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

  NotificationCenter {
    id: ncCenter
    history: history
  }

  function removeById(id) {
    history.remove(id);
  }

  function toggleNotifCenter() {
    ncCenter.active = !ncCenter.active;
  }
}
