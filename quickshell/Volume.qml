import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Text {
  id: volWidget
  color: root.colTextDark

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

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: -1
    exclusiveZone: -1

    color: "transparent"

    RowLayout {
      anchors.fill: parent

      VolumeSlider {}
    }
  }

  font {
    bold: true
    family: root.fontFamily
    pixelSize: root.fontSize
    letterSpacing: 0.5
  }

  text: audio.volume !== 0 ? `󰕾  ${volume}%` : `󰝟  ${volume}%`

  MouseArea {
    anchors.fill: parent

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: Hyprland.dispatch("exec pavucontrol")
    onEntered: volWidget.showSlider = true
  }
}
