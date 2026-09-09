pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string imagePath: ""

  function setImage(path) {
    matugenProc.command = ["matugen", "image", path, "--source-color-index", "0"];
    matugenProc.running = true;
    root.imagePath = path
  }

  function getWallpaperPath() {
    awwwQueryProc.running = true
    return root.imagePath
  }

  Process {
    id: matugenProc
    command: ["sh", "-c", ""]
  }

  // Get current wallpaper using awww
  Process {
    id: awwwQueryProc
    running: true
    command: ["sh", "-c", "awww query --json | jq -r '.\"\".[0].displaying.image'"]
    stdout: SplitParser {
      onRead: data => {
        root.imagePath = data.trim();
      }
    }
  }
}
