pragma Singleton
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
  id: root

  property int exponent: 2

  property real brightnessValue: 0
  property int brightnessPercent: Math.floor(root.brightnessValue * 100)
  property int maxBrightness: 0

  signal brightnessChanged

  function increase() {
    if (root.brightnessPercent === 100)
      return;

    brightnessProc.exec(["brightnessctl", `-e${root.exponent}`, "set", "5%+"]);
    brightnessInitProc.running = true;
    root.brightnessChanged();
  }

  function decrease() {
    if (root.brightnessPercent <= 1)
      return;

    brightnessProc.exec(["brightnessctl", `-e${root.exponent}`, "set", "5%-"]);
    brightnessInitProc.running = true;
    root.brightnessChanged();
  }

  Process {
    id: brightnessInitProc
    running: true
    command: ["sh", "-c", "echo \"$(brightnessctl g) $(brightnessctl m)\""]
    stdout: SplitParser {
      onRead: data => {
        const [current, max] = data.split(" ");
        root.maxBrightness = parseInt(max);
        root.brightnessValue = parseInt(current) / root.maxBrightness;
      }
    }
  }

  Process {
    id: brightnessProc
  }

  IpcHandler {
    target: "brightness"

    function increase(): void {
      root.increase();
    }
    function decrease(): void {
      root.decrease();
    }
  }
}
