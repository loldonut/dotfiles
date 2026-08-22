pragma Singleton
import QtQuick
import Quickshell

// from https://github.com/end-4/dots-hyprland

Singleton {
  function getBatteryIcon(percentage: int): string {
    if (percentage >= 93)
      return "battery_android_full";
    if (percentage >= 78)
      return "battery_android_6";
    if (percentage >= 64)
      return "battery_android_5";
    if (percentage >= 50)
      return "battery_android_4";
    if (percentage >= 35)
      return "battery_android_3";
    if (percentage >= 21)
      return "battery_android_2";
    if (percentage >= 7)
      return "battery_android_1";
    return "battery_android_0";
  }

  function getVolumeIcon(percentage: int, muted: bool): string {
    if (muted) {
      return "volume_mute";
    }

    return percentage > 49 ? "volume_up" : "volume_down";
  }
}
