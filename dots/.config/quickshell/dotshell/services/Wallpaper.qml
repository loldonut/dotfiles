pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string imagePath: ""

  // Get current wallpaper using awww
  Process {
    running: true
    command: ["sh", "-c", "awww query --json | jq -r '.\"\".[0].displaying.image'"]
    stdout: SplitParser {
      onRead: data => {
        root.imagePath = data.trim();
      }
    }
  }
}

