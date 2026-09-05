pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

import qs.modules.common
import qs.modules.config
import qs.services

FocusablePanelWindow {
  id: volMenu

  visible: false

  color: "transparent"

  implicitWidth: MprisController.activePlayer !== null ? 800 : 550
  implicitHeight: 300

  anchors {
    top: true
    right: true
  }

  margins {
    top: 10
    right: 10
  }

  Rectangle {
    anchors.fill: parent
    radius: 10

    color: Colors.md3.surface
    border.color: Colors.md3.inverse_primary
    border.width: 2

    RowLayout {
      anchors.fill: parent
      anchors.margins: 10

      ScrollView {
        visible: MprisController.activePlayer !== null
        Layout.fillHeight: true
        Layout.preferredWidth: 300
        Layout.margins: 10
        contentWidth: availableWidth

        ColumnLayout {
          Repeater {
            model: MprisController.players

            MprisEntry {
              id: mprisEntry
              required property MprisPlayer modelData
              implicitWidth: 300
              player: modelData

              FrameAnimation {
                running: volMenu.visible && (mprisEntry.player.playbackState === MprisPlaybackState.Playing)
                onTriggered: mprisEntry.player.positionChanged()
              }
            }
          }
        }
      }

      Rectangle {
        visible: MprisController.activePlayer !== null
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        Layout.leftMargin: -4
        Layout.rightMargin: -4
        Layout.topMargin: 12
        Layout.bottomMargin: 12
        opacity: 0.2
        color: Colors.md3.primary
      }

      ScrollView {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumWidth: 550
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
            color: Colors.md3.on_primary
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
}
