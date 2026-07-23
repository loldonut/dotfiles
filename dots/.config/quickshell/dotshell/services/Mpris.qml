import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.modules.config

Scope {
  id: root

  property bool showMpris: false

  LazyLoader {
    id: mpris
    active: root.showMpris

    FloatingWindow {
      color: Colors.bg

      title: "Mpris"

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8
        anchors.leftMargin: 24

        MprisEntry {
          player: Mpris.players.values[0]
        }
      }

    }
  }

  IpcHandler {
    target: "mpris"

    function toggle() { root.showMpris = !root.showMpris }
    function hide() { root.showMpris = false }
    function show() { root.showMpris = true }
  }
}
