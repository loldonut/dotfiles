pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  readonly property string time: {
    Qt.formatDateTime(clock.date, "ddd, MMMM d, yyyy hh:mm AP")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
