import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire

import qs.modules.common
import qs.modules.config

ColumnLayout {
  required property PwNode node
  property real prevVolume: node.audio.volume

  PwObjectTracker {
    objects: [node]
  }

  RowLayout {
    MaterialSymbol {
      text: (node?.audio?.volume !== 0 && !node?.audio?.muted) ? `volume_up` : `volume_mute`
    }

    StyledText {
      Layout.fillWidth: true
      color: Colors.md3.primary
      elide: Text.ElideRight
      text: {
        const app = node?.properties["application.name"] ?? (node?.description != "" ? node?.description : node.name) ?? "";
        const media = node?.properties["media.name"];
        return media !== undefined ? `${app} - ${media}` : app;
      }
    }

    Button {
      id: muteBtn
      text: node?.audio?.muted ? "unmute" : "mute"
      onClicked: node.audio.muted = !node.audio.muted

      contentItem: StyledText {
        text: node?.audio.muted ? "unmute" : "mute"
        opacity: enabled ? 1.0 : 0.3
        color: Colors.md3.primary
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
      }

      background: Rectangle {
        implicitWidth: 80
        implicitHeight: 20
        opacity: enabled ? 1 : 0.3
        color: Colors.md3.on_primary
        radius: 4
      }

      HoverHandler {
        cursorShape: Qt.PointingHandCursor
      }
    }
  }

  RowLayout {
    StyledText {
      color: Colors.md3.primary
      font.bold: true
      Layout.preferredWidth: 50
      text: `${Math.round(node?.audio?.volume * 100)}%`
    }

    Connections {
      target: node.audio

      function onMutedChanged() {
        if (node.audio.muted) {
          control.prevVolume = node.audio.volume;
          control.value = 0;
        } else {
          control.value = control.prevVolume;
        }
      }
    }

    StyledSlider {
      id: control
      Layout.fillWidth: true
      value: node?.audio?.volume ?? 0
      onValueChanged: node.audio.volume = value
      enabled: !node.audio.muted
      stepSize: 0.05

      fillColor: Colors.md3.primary
      posColor: Colors.md3.on_primary

      WheelHandler {
        target: control
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => {
          if (event.angleDelta.y > 0) {
            control.increase();
          } else {
            control.decrease();
          }
        }
      }
    }
  }
}
