pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property QtObject font: QtObject {
    property string family: "JetBrainsMono Nerd Font"
    property int size: 16
  }

  property QtObject bar: QtObject {
    property int height: 33
  }

  property QtObject notifications: QtObject {
    property int timeout: 5000
  }
}
