import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.modules.config

Item {
  required property QsMenuEntry entry

  Layout.fillWidth: true
  Layout.preferredHeight: entry.isSeparator ? 1 : 34

  Rectangle {
    visible: entry.isSeparator
    width: parent.width
    height: 1
    color: Colors.md3.primary
    opacity: 0.25
  }

  Rectangle {
    visible: !entry.isSeparator
    anchors.fill: parent
    radius: 4
    color: Colors.md3.on_primary
    opacity: entryMouse.containsMouse && entry.enabled ? 1 : 0
  }

  RowLayout {
    visible: !entry.isSeparator

    anchors.fill: parent
    Layout.margins: 10
    Layout.leftMargin: 20

    Image {
      source: entry.icon
      Layout.leftMargin: 8
      Layout.preferredWidth: 14
      Layout.preferredHeight: 14
      Layout.alignment: Qt.AlignVCenter
      sourceSize.width: width
      sourceSize.height: height
    }

    ColumnLayout {
      Layout.fillWidth: true

      StyledText {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        visible: !entry.isSeparator
        font.pixelSize: Config.font.size + 2
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
    cursorShape: entry.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

    onClicked: {
      entry.triggered();
      trayMenu.visible = false;
    }
  }
}
