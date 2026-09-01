//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.lock
import qs.modules.bar
import qs.modules.wallpapers
import qs.services
import qs.services.notifications

ShellRoot {
  Wallpapers {}

  VolumeOverlay {}
  BrightnessOverlay {}

  SessionLock {}

  Bar {}

  GlobalShortcut {
    name: "notifCenter"

    onPressed: {
      Notifications.toggleNotifCenter();
    }
  }

  GlobalShortcut {
    name: "brightnessUp"

    onPressed: Brightness.increase()
  }

  GlobalShortcut {
    name: "brightnessDown"

    onPressed: Brightness.decrease()
  }
}
