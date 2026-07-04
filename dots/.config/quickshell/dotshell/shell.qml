//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules.bar
import qs.modules.wallpapers
import qs.services

ShellRoot {
  settings.watchFiles: true

  Notifications {}
  Wallpapers {}
  VolumeOverlay {}

  Bar {}
}
