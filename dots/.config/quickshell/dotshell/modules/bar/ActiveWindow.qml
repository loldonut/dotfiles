import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules.config

RowLayout {
  anchors.centerIn: parent
  spacing: 8

  IconImage {
    source: Quickshell.iconPath(Hyprland.activeToplevel.title, true)
    width: 24
    height: 24
  }

  Text {
    id: activeWindow

    font.family: Config.font.family
    font.bold: true
    color: Colors.fg

    text: getWindowTitle()
    maximumLineCount: 1
    elide: Text.ElideRight

    function getWindowTitle() {
      var activeWindowTitle = Hyprland.activeToplevel?.title || " "
      if (activeWindowTitle.length > 40) {
        activeWindowTitle = activeWindowTitle.substr(0, 40) + '...'
      }
      return activeWindowTitle
    }

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
}
