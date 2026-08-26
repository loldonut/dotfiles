import Quickshell
import Quickshell.Hyprland

PanelWindow {
  id: root

  focusable: true

  HyprlandFocusGrab {
    active: root.visible
    windows: [root]
    onCleared: root.visible = false
  }
}
