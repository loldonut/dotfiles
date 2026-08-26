pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

import qs.modules.common

Singleton {
  id: root

  property alias bar: jsonAdapter.bar
  property alias notifications: jsonAdapter.notifications
  property alias font: jsonAdapter.font

  FileView {
    path: Paths.shellConfig
    watchChanges: true
    onFileChanged: reload()
    onLoadFailed: error => {
      if (error === FileViewError.FileNotFound) {
        writeAdapter();
      }
    }

    JsonAdapter {
      id: jsonAdapter

      readonly property Bar bar: Bar {}
      readonly property Notifications notifications: Notifications {}
      readonly property FontOptions font: FontOptions {}
    }
  }

  component Bar: JsonObject {
    property bool floating: true
    property int height: 50 * root.bar.scale
    property real scale: 1.0
    property bool shortTimeFormat: true
  }

  component Notifications: JsonObject {
    property int criticalTimeout: 15000
    property int timeout: 7000
  }

  component FontOptions: JsonObject {
    property string family: "Google Sans Flex"
    property string propo: "JetBrainsMono Nerd Font Propo"
    property string symbols: "Material Symbols Rounded"
    property int size: 14 * root.bar.scale
    property int iconSize: 16 * root.bar.scale
  }
}
