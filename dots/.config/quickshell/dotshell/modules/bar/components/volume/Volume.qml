import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.modules.config

Text {
  id: volWidget
  anchors.verticalCenter: parent.verticalCenter
  color: Colors.fg

  property bool showSlider: false
  readonly property PwNodeAudio audio: Pipewire.defaultAudioSink.audio
  readonly property real rawVolume: audio.volume
  property int volume: Math.round((rawVolume ?? 0) * 100)

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
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

      VolumeSlider {}
    }
  }

  font {
    bold: true
    family: Config.font.family
    pixelSize: Config.font.size - 4
    letterSpacing: 0.5
  }

  text: (audio.volume !== 0 && !audio.muted) ? `󰕾 ${volume}%` : `󰝟 ${volume}%`

  MouseArea {
    anchors.fill: parent

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: volWidget.showSlider = !volWidget.showSlider
  }
}
