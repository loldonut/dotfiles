pragma Singleton
import Qt.labs.platform
import QtQuick
import Quickshell

Singleton {
  id: root

  property QtObject font: QtObject {
    property string family: "Google Sans Flex"
    property string propo: "JetBrainsMono Nerd Font Propo"
    property string symbols: "Material Symbols Rounded"
    property int size: 14 * root.bar.scale
    property int iconSize: 16 * root.bar.scale
  }

  property QtObject bar: QtObject {
    property bool floating: true
    property int height: 50 * root.bar.scale
    property real scale: 1.0
    property bool shortTimeFormat: true
    property string wallpaperPath: StandardPaths.writableLocation(StandardPaths.HomeLocation) + "/Pictures/Wallpapers"
  }

  property QtObject notifications: QtObject {
    property int criticalTimeout: 15000
    property int timeout: 7000
  }
}
