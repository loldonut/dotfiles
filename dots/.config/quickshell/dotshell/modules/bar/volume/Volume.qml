pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

import qs.modules.common

StyledBarRect {
  id: root

  property bool showSlider: false
  readonly property PwNodeAudio audio: Pipewire.defaultAudioSink.audio
  property int volume: Math.round((audio?.volume ?? 0) * 100)
  property int maxVolume: 100
  property real stepSize: 0.05

  implicitWidth: volRow.implicitWidth + 15

  PwNodeLinkTracker {
    node: Pipewire.defaultAudioSink
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  RowLayout {
    id: volRow
    anchors.centerIn: parent

    MaterialSymbol {
      text: Symbols.getVolumeIcon(root.volume, root.audio?.muted)
    }

    StyledText {
      id: volWidget
      Layout.alignment: Qt.AlignVCenter

      text: root.audio.muted ? `0%` : `${root.volume}%`
    }
  }

  LazyLoader {
    id: volSliderLoader
    loading: true

    VolumeSlider {}
  }

  function increaseVolume() {
    if (root.volume < root.maxVolume) {
      root.audio.volume += stepSize;
    }
  }

  function decreaseVolume() {
    if (root.volume > 0) {
      root.audio.volume -= stepSize;
    }
  }

  MouseArea {
    anchors.fill: parent

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      volSliderLoader.item.visible = !volSliderLoader.item.visible;
    }

    WheelHandler {
      acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
      onWheel: event => {
        if (event.angleDelta.y > 0) {
          root.increaseVolume();
        } else {
          root.decreaseVolume();
        }
      }
    }
  }

  Behavior on implicitWidth {
    NumberAnimation {
      easing {
        type: Easing.OutQuart
        amplitude: 1
        period: 0.5
      }
    }
  }
}
