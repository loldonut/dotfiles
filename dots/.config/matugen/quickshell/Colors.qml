pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property string fg: "{{ colors.primary.default.hex }}"
  property string bg: "{{ colors.surface.default.hex }}"
  property string onPrimary: "{{ colors.on_primary.default.hex }}"
  property string inversePrimary: "{{ colors.inverse_primary.dark.hex }}"
  property string onSecondaryFixed: "{{ colors.on_secondary_fixed.dark.hex }}"
}
