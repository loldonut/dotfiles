pragma Singleton

import Quickshell
import QtQuick

// your singletons should always have Singleton as the type
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
