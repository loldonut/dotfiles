pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs.modules.common
import qs.modules.config
import qs.services

Rectangle {
  id: root

  required property MprisPlayer player

  color: Colors.md3.on_primary
  radius: 8

  implicitWidth: layoutContainer.implicitWidth
  implicitHeight: layoutContainer.implicitHeight + 20

  visible: MprisController.isValidPlayer(root.player)

  Image {
    id: trackArt

    anchors.fill: parent

    asynchronous: true
    source: root.player.trackArtUrl
    fillMode: Image.PreserveAspectCrop
    visible: false
  }

  MultiEffect {
    visible: root.player?.trackArtUrl !== ""
    source: trackArt
    anchors.fill: trackArt
    opacity: 0.8

    autoPaddingEnabled: false
    blurEnabled: true
    blur: 0.5

    brightness: -0.1

    maskEnabled: true
    maskSource: mask
  }

  Item {
    id: mask
    width: trackArt.width
    height: trackArt.height
    layer.enabled: true
    visible: false

    Rectangle {
      width: trackArt.width
      height: trackArt.height
      radius: root.radius
    }
  }

  Rectangle {
    anchors.fill: parent
    visible: root.player?.trackArtUrl !== ""
    radius: parent.radius
    gradient: LeftSideGradient {}

    // component RightGradient: Gradient {
    //   orientation: Gradient.Horizontal
    //   GradientStop { position: 0.0; color: "transparent" }
    //   GradientStop { position: 0.6; color: Colors.md3.on_primary }
    // }
  }

  component LeftSideGradient: Gradient {
    orientation: Gradient.Horizontal
    GradientStop {
      position: 0.5
      color: Colors.md3.on_primary
    }
    GradientStop {
      position: 1.0
      color: "transparent"
    }
  }

  ColumnLayout {
    id: layoutContainer
    anchors.fill: parent
    anchors.margins: 10

    RowLayout {
      ColumnLayout {
        StyledText {
          Layout.fillWidth: true
          elide: Text.ElideRight
          font.pixelSize: 18
          text: root.player.trackTitle
        }

        StyledText {
          opacity: 0.8
          font.pixelSize: 16
          color: Colors.md3.secondary
          text: root.player.trackArtist
        }
      }

      MaterialSymbol {
        size: 26
        text: "skip_previous"

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: root.player.previous()
        }
      }

      MaterialSymbol {
        size: 28
        text: root.player.isPlaying ? "pause" : "play_arrow"

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: root.player.togglePlaying()
        }
      }

      MaterialSymbol {
        size: 26
        text: "skip_next"

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: root.player.next()
        }
      }
    }

    RowLayout {
      Layout.fillWidth: true

      StyledText {
        font.pixelSize: 16
        Layout.preferredWidth: 70
        text: root.formatTime(root.player.position)
      }

      StyledSlider {
        id: control

        Layout.fillWidth: true

        property real pos: root.player.position / root.player.length

        fillColor: Colors.md3.on_secondary_fixed

        enabled: root.player.canSeek
        value: pos
        from: 0
        to: 1
        onPressedChanged: root.player.position = (value * root.player.length)
      }

      StyledText {
        Layout.leftMargin: 5
        font.pixelSize: 16
        text: root.formatTime(root.player.length)

        layer.enabled: true
        layer.effect: MultiEffect {
          shadowEnabled: true
          shadowColor: Colors.md3.shadow
          shadowBlur: 0.8
          shadowHorizontalOffset: 3
          shadowVerticalOffset: 3
        }
      }
    }
  }

  function formatTime(seconds) {
    const hrs = Math.floor(seconds / 3600);
    const mins = Math.floor((seconds % 3600) / 60);
    const secs = Math.floor(seconds % 60);

    const paddedMins = String(mins).padStart(2, '0');
    const paddedSecs = String(secs).padStart(2, '0');

    if (hrs > 0) {
      const paddedHrs = String(hrs).padStart(2, '0');
      return `${paddedHrs}:${paddedMins}:${paddedSecs}`;
    }

    return `${paddedMins}:${paddedSecs}`;
  }
}
