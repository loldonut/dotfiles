import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs

Scope {
  LockContext {
    id: lockContext
    onUnlocked: {
      ShellState.locked = false;
    }
  }

  WlSessionLock {
    id: lock

    locked: ShellState.locked

    WlSessionLockSurface {
      LockSurface {
        id: container
        anchors.fill: parent
        context: lockContext
      }
    }
  }

  GlobalShortcut {
    name: "lock"

    onPressed: {
      ShellState.locked = true;
    }
  }
}
