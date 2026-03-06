import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Text {
  id: activewindow
  property string activeWindow: "Window"

  anchors {
    fill: parent
  }

  color: root.colTextDark
  fontSizeMode: Text.Fit
  wrapMode: Text.WordWrap
  elide: Text.ElideRight
  maximumLineCount: 1

  font {
    pixelSize: root.fontSize
    family: root.fontFamilyNerdFont
    letterSpacing: 0.6
    bold: true
  }

  text: activeWindow
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

  Process {
    id: windowProc
    command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
    stdout: SplitParser {
      onRead: data => {
        if (data && data.trim()) {
          activeWindow = data.trim()
        }
      }
    }
    Component.onCompleted: running = true
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      windowProc.running = true
    }
  }

  Behavior on text {
    SequentialAnimation {
      NumberAnimation {
        target: activewindow
        property: "opacity"
        to: 0.0
        duration: 0
      }

      NumberAnimation {
        target: activewindow
        property: "opacity"
        to: 1.0
        duration: 500
        easing.type: Easing.OutQuad
      }
    }
  }
}
