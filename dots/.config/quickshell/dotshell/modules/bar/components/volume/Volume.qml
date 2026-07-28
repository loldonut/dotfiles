import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

import qs.modules.common
import qs.modules.config

StyledBarRect {
  property bool showSlider: false
  readonly property PwNodeAudio audio: Pipewire.defaultAudioSink.audio
  readonly property real rawVolume: audio.volume
  property int volume: Math.round((rawVolume ?? 0) * 100)

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

  MouseArea {
    anchors.fill: parent

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: volSlider.visible = !volSlider.visible
  }
}
