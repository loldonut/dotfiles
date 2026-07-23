import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts

import qs.modules.config

RowLayout {
  required property MprisPlayer player;

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
    Text {
      Layout.fillWidth: true

      color: Colors.fg
      font {
        family: Config.font.family
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

    Text {
      visible: player?.trackAlbum !== null
      font {
        family: Config.font.family
        pixelSize: 12
      }
      text: player?.trackAlbum || ""
      color: Colors.fg
    }

    Text {
      id: trackTime
      font {
        family: Config.font.family
        pixelSize: 22
      }
      text: {
        if (!player?.trackArtist) {
          return "Unknown Artist"
        }

        return `${player.trackArtist}`
      }
      color: Colors.fg
    }

    Rectangle {
      visible: player?.position !== null
      id: trackBar
      implicitHeight: 10
      implicitWidth: 500
      radius: 20

      color: Colors.onPrimary

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
          const m = Math.floor(seconds / 60).toString().padStart(2, '0')
          const s = Math.floor(seconds % 60).toString().padStart(2, '0')

          return `${m}:${s}`
      }

      Text {
        color: Colors.onPrimary
        font {
          family: Config.font.family
        }
        text: parent.formatTime(player.position)
      }

      Text {
        color: Colors.onPrimary
        font {
          family: Config.font.family
        }
        text: "—"
      }

      Text {
        color: Colors.onPrimary
        font {
          family: Config.font.family
        }
        text: parent.formatTime(player.length)
      }
    }

    // Playback Actions
    RowLayout {
      spacing: 16

      Text {
        color: Colors.fg
        font {
          family: Config.font.family
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

        color: Colors.fg

        Text {
          anchors.centerIn: parent
          color: Colors.onPrimary
          font {
            family: Config.font.family
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

      Text {
        color: Colors.fg
        font {
          family: Config.font.family
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

