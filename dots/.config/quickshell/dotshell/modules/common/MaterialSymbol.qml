import QtQuick

import qs.modules.common
import qs.modules.config

// from https://github.com/end-4/dots-hyprland

StyledText {
  property real size: Config.font.size
  property real fill: 0
  property real truncatedFill: fill.toFixed(1)

  renderType: Text.NativeRendering
  font {
    hintingPreference: Font.PreferNoHinting
    family: Config.font.symbols
    pixelSize: size
    weight: Font.Normal + (Font.DemiBold - Font.Normal) * truncatedFill
    variableAxes: {
      "FILL": truncatedFill,
      "opsz": size,
    }
  }
}
