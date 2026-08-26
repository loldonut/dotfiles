import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Wayland

import qs.modules.common
import qs.modules.config

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
      text: Symbols.getVolumeIcon(volume, audio?.muted)
    }

    StyledText {
      id: volWidget
      Layout.alignment: Qt.AlignVCenter

      text: `${volume}%`
    }
  }

  PanelWindow {
    id: volPopup
    anchors {
      top: parent
      right: true
    }

    margins {
      top: 38
      right: 310
    }

    implicitHeight: 50
    implicitWidth: 250

    visible: volWidget.showSlider

    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    RowLayout {
      anchors.fill: parent

      VolumeSlider {
        id: volSlider
      }
    }
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

    onClicked: volSlider.visible = !volSlider.visible

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
}
