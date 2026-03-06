import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick

WrapperItem {
  rightMargin: 5
  leftMargin: 5

  Text {
    id: notification

    color: root.colBlue
    font {
      family: root.fontFamilyNerd
      pixelSize: root.fontSize + 4
    }

    text: NotificationServer.trackedNotifications  ? "󱅫" : ""

    MouseArea {
      anchors.fill: parent

      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      // onClicked:
    }
  }
}
