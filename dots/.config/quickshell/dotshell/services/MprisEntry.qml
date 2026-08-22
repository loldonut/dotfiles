import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs.modules.common
import qs.modules.config

RowLayout {
  required property MprisPlayer player

  spacing: 20

  Image {
    id: trackArt
    visible: player?.trackArtUrl !== null
    source: player?.trackArtUrl || ""
    fillMode: Image.PreserveAspectFit

    sourceSize.width: 140
    sourceSize.height: 140

    layer.enabled: true
    layer.effect: OpacityMask {
      id: opacityMaskInstance
      maskSource: Rectangle {
        id: maskedRect
        width: trackArt.width
        height: trackArt.height
        radius: 30
      }
    }
  }

  ColumnLayout {
    StyledText {
      Layout.fillWidth: true

      font {
        pixelSize: 30
        bold: true
      }

      wrapMode: Text.Wrap
      maximumLineCount: 2
      elide: Text.ElideRight
      text: player?.trackTitle || "Unknown Title"

      transitions: Transition {
        PropertyAnimation {
          duration: 200
          easing.type: Easing.OutQuad
          easing.amplitude: 1.0
          easing.period: 1.5
        }
      }
    }

    StyledText {
      visible: player?.trackAlbum !== null
      font.pixelSize: 12
      text: player?.trackAlbum || ""
    }

    StyledText {
      id: trackTime
      font.pixelSize: 22
      text: {
        if (!player?.trackArtist) {
          return "Unknown Artist";
        }

        return `${player.trackArtist}`;
      }
    }

    Rectangle {
      id: trackBar
      visible: player?.position !== null
      implicitHeight: 10
      implicitWidth: 500
      radius: 20

      color: Colors.md3.on_primary

      Rectangle {
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }

        implicitWidth: parent.width * (player.position / player.length)
        radius: parent.radius
      }

      FrameAnimation {
        running: player?.playbackState === MprisPlaybackState.Playing
        onTriggered: player.positionChanged()
      }
    }

    RowLayout {
      spacing: 8
      function formatTime(seconds) {
        const m = Math.floor(seconds / 60).toString().padStart(2, '0');
        const s = Math.floor(seconds % 60).toString().padStart(2, '0');

        return `${m}:${s}`;
      }

      StyledText {
        color: Colors.md3.on_primary
        text: parent.formatTime(player.position)
      }

      StyledText {
        color: Colors.md3.on_primary
        text: "—"
      }

      StyledText {
        color: Colors.md3.on_primary
        text: parent.formatTime(player.length)
      }
    }

    // Playback Actions
    RowLayout {
      spacing: 16

      StyledText {
        font {
          pixelSize: 40
          bold: true
        }

        text: "󰒮"

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: player.previous()
        }
      }

      // Play / Pause
      Rectangle {
        implicitHeight: 55
        implicitWidth: 55

        radius: 50

        color: Colors.md3.primary

        StyledText {
          anchors.centerIn: parent
          color: Colors.md3.on_primary
          font {
            pixelSize: 40
            bold: true
          }

          text: player?.playbackState === MprisPlaybackState.Playing ? "" : "󰐊"
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: player.togglePlaying()
        }
      }

      StyledText {
        font {
          pixelSize: 40
          bold: true
        }

        text: "󰒭"

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: player.next()
        }
      }
    }
  }
}
