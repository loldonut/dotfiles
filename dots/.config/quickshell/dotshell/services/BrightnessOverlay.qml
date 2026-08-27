import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.modules.config
import qs.services

Scope {
  id: root

  property bool shouldShowOsd: false

  Connections {
    target: Brightness

    function onBrightnessChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.bottom: true
      margins.bottom: screen.height / 5
      exclusiveZone: 0

      implicitWidth: 360
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: 10
        color: Colors.md3.surface

        border.color: Colors.md3.primary
        border.width: 2

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 15
            rightMargin: 15
          }

          MaterialSymbol {
            size: 22
            text: Symbols.getBrightnessOSDIcon(Brightness.brightnessPercent)
          }

          ProgressBar {
            id: control
            value: Brightness.brightnessValue
            padding: 2

            background: Rectangle {
              implicitWidth: 300
              implicitHeight: 10
              color: Colors.md3.on_primary
              radius: width / 2
            }

            contentItem: Item {
              implicitWidth: 200
              implicitHeight: 10

              Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                radius: width / 2
                color: Colors.md3.primary
                visible: !control.indeterminate

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
          }
        }
      }
    }
  }
}
