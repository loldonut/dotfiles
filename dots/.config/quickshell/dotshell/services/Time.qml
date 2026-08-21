pragma Singleton

import QtQuick
import Quickshell

import qs.modules.config

Singleton {
  function getDateAndTime(shortFormat) {
    if (shortFormat) {
      return Qt.formatDateTime(clock.date, "MMM d, yyyy hh:mm AP");
    } else {
      return Qt.formatDateTime(clock.date, "ddd, MMMM d, yyyy hh:mm AP");
    }
  }

  function getTime(format) {
    return Qt.formatDateTime(clock.date, format);
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
