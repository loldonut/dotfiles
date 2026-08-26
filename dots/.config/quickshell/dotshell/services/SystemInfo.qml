pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// partly from https://github.com/end-4/dots-hyprland

Singleton {
  id: root

  property string user: ""
  property string uptime: ""

  Timer {
    interval: 10000
    running: true
    repeat: true
    onTriggered: uptimeProc.running = true
  }

  Process {
    id: uptimeProc
    running: true
    command: ["sh", "-c", "uptime --pretty"]
    stdout: SplitParser {
      onRead: data => {
        root.uptime = data.slice(3);
      }
    }
  }

  Process {
    running: true
    command: ["sh", "-c", "whoami"]
    stdout: SplitParser {
      onRead: data => {
        root.user = data.trim();
      }
    }
  }
}
