import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.config

Item {
  required property QsMenuEntry entry

  Layout.fillWidth: true
  Layout.preferredHeight: entry.isSeparator ? 8 : 34

  Rectangle {
    visible: entry.isSeparator
    width: parent.width
    height: 1
    color: Colors.fg
    opacity: 0.25
  }

  Rectangle {
    visible: !entry.isSeparator
    anchors.fill: parent
    radius: 4
    color: Colors.onPrimary
    opacity: entryMouse.containsMouse && entry.enabled ? 1 : 0
  }

  RowLayout {
    visible: !entry.isSeparator

    anchors.fill: parent
    Layout.fillWidth: true

    Image {
      source: entry.icon
      Layout.preferredWidth: 14
      Layout.preferredHeight: 14
      Layout.alignment: Qt.AlignVCenter
      sourceSize.width: width
      sourceSize.height: height
    }

    ColumnLayout {
      Layout.fillWidth: true

      Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        visible: !entry.isSeparator
        font {
          family: Config.font.family
          pixelSize: Config.font.size + 2
        }
        color: Colors.fg
        elide: Text.ElideRight
        text: entry.text
      }
    }
  }

  MouseArea {
    id: entryMouse
    anchors.fill: parent
    visible: !entry.isSeparator
    enabled: entry.enabled
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      entry.triggered()
      trayMenu.visible = false
    }
  }
}
