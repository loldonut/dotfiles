import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Pipewire

import qs.modules.config

PanelWindow {
  id: volMenu

  visible: false

  color: "transparent"

  implicitWidth: 600
  implicitHeight: 300

  anchors {
    top: true
    right: true
  }

  margins {
    top: 10
    right: 10
  }

  HyprlandFocusGrab {
    active: volMenu.visible
    windows: [volMenu]
    onCleared: volMenu.visible = false
  }

  Rectangle {
    anchors.fill: parent
    radius: 10

    color: Colors.bg
    border.color: Colors.inversePrimary
    border.width: 2

    ScrollView {
      anchors.fill: parent
      contentWidth: availableWidth

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        PwNodeLinkTracker {
          id: linkTracker
          node: Pipewire.defaultAudioSink
        }

        MixerEntry {
          node: Pipewire.defaultAudioSink
        }

        Rectangle {
          Layout.fillWidth: true
          color: Colors.onPrimary
          implicitHeight: 1
        }

        Repeater {
          model: linkTracker.linkGroups

          MixerEntry {
            required property PwLinkGroup modelData
            node: modelData.source
          }
        }
      }
    }
  }
}

