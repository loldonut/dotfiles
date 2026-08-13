pragma Singleton

import QtQuick
import Quickshell

import qs.modules.config

Singleton {
  function getTime(shortFormat) {
    if (shortFormat) {
      return Qt.formatDateTime(clock.date, "ddd, MMMM d, yyyy hh:mm AP")
    } else {
      return Qt.formatDateTime(clock.date, "MMM d, yyyy hh:mm AP")
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
