pragma Singleton
import Quickshell
import Quickshell.Io

// partly from https://github.com/end-4/dots-hyprland

Singleton {
  id: root
  property string user: ""

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
