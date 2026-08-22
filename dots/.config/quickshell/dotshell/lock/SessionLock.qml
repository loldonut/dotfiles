import QtQuick
import Quickshell
import Quickshell.Io
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

  IpcHandler {
    target: "lock"

    function activate(): void {
      ShellState.locked = true;
    }
  }
}
