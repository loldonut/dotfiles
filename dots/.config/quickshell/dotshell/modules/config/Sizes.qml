pragma Singleton
import QtQuick
import Quickshell

Singleton {
  property QtObject bar: QtObject {
    property real defaultBarHeight: 52
  }

  property QtObject font: QtObject {
    // property int smallest: 10
    // property int smaller: 12
    // property int smallie: 13
    property int small: 15
    property int normal: 16
    property int large: 17
    property int larger: 19
    property int huge: 22
    // property int hugeass: 23
    property int title: huge
  }
}
