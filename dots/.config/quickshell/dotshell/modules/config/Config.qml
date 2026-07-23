pragma Singleton
import Qt.labs.platform
import QtQuick
import Quickshell

Singleton {
  property QtObject font: QtObject {
    property string family: "Google Sans Flex"
    property string propo: "JetBrainsMono Nerd Font Propo"
    property int size: 14 * bar.scale
  }

  property QtObject bar: QtObject {
    property int height: 40
    property real scale: 1.0
    property string wallpaperPath: StandardPaths.writableLocation(StandardPaths.HomeLocation) + "/Pictures/Wallpapers"
  }

  property QtObject notifications: QtObject {
    property int timeout: 5000
  }
}
