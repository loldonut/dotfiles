import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick

WrapperItem {
  rightMargin: 5
  leftMargin: 5

  Text {
    id: notification

    color: root.colTextDark
    font {
      family: root.fontFamilyNerd
      pixelSize: root.fontSize + 4
    }

    NotificationServer {
      keepOnReload: true
      imageSupported: true
      persistenceSupported: true
      bodySupported: true

      onNotification: console.log(notification)
    }

    // text: NotificationServer.trackedNotifications.values  ? "󱅫" : ""
    text: "m"

    MouseArea {
      anchors.fill: parent

      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      // onClicked: Hyprland.dispatch("exec swaync-client --open-panel")
      onClicked: console.log(NotificationServer.trackedNotifications)
    }
  }
}
