//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Io

import qs.lock
import qs.modules.bar
import qs.modules.wallpapers
import qs.services
import qs.services.notifications

ShellRoot {
  Notifications {}
  Wallpapers {}
  VolumeOverlay {}
  Mpris {}

  SessionLock {}

  Bar {}
}
