import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire

import qs.modules.common
import qs.modules.config

ColumnLayout {
  required property PwNode node

  PwObjectTracker {
    objects: [node]
  }

  RowLayout {
    MaterialSymbol {
      text: (node?.audio?.volume !== 0 && !node?.audio?.muted) ? `volume_up` : `volume_mute`
    }

    Label {
      Layout.fillWidth: true
      color: Colors.md3.primary
      font {
        family: Config.font.family
        pixelSize: Config.font.size
      }
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
    Label {
      color: Colors.md3.primary
      font {
        family: Config.font.family
        pixelSize: Config.font.size
        bold: true
      }
      Layout.preferredWidth: 50
      text: `${Math.round(node?.audio?.volume * 100)}%`
    }

    Slider {
      id: control
      Layout.fillWidth: true
      value: node?.audio?.volume ?? 0
      onValueChanged: node.audio.volume = value
      stepSize: 0.05

      background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 6
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: Colors.md3.on_primary

        Rectangle {
          width: control.visualPosition * parent.width
          height: parent.height
          color: Colors.md3.primary
          radius: 2

          Behavior on width {
            NumberAnimation {
              easing {
                type: Easing.OutQuart
                amplitude: 1
                period: 0.5
              }
            }
          }
        }
      }

      handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 10
        implicitHeight: 26
        radius: 5
        color: Colors.md3.surface
        border.color: Colors.md3.primary

        Behavior on x {
          NumberAnimation {
            easing {
              type: Easing.OutQuart
              amplitude: 1
              period: 0.5
            }
          }
        }
      }

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
