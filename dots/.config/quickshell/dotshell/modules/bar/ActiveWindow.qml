import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.modules.common
import qs.modules.config

StyledText {
  id: activeWindow
  Layout.alignment: Qt.AlignCenter
  Layout.maximumWidth: 250

  color: Colors.fg

  text: Hyprland.activeToplevel?.title || ""
  maximumLineCount: 1
  elide: Text.ElideRight

  Behavior on text {
    SequentialAnimation {
      NumberAnimation {
        target: activeWindow
        property: "opacity"
        to: 0.0
        duration: 0
      }

      NumberAnimation {
        target: activeWindow
        property: "opacity"
        to: 1.0
        duration: 200
        easing.type: Easing.OutQuad
      }
    }
  }
}
