pragma Singleton
import Qt.labs.platform
import QtQuick
import Quickshell

Singleton {
  id: root

  property string home: StandardPaths.writableLocation(StandardPaths.HomeLocation)
  property string pictures: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
  property string config: StandardPaths.writableLocation(StandardPaths.ConfigLocation)

  property string configName: "dotfiles"
  property string shellConfig: trimFileProtocol(`${Paths.shellConfigFolder}/config.json`)
  property string shellConfigFolder: trimFileProtocol(`${Paths.config}/${configName}`)
  property string wallpaperPath: `${Paths.pictures}/Wallpapers`

  // from https://github.com/end-4/dots-hyprland
  function trimFileProtocol(str) {
    let s = str;
    if (typeof s !== "string")
      s = str.toString();
    return s.startsWith("file://") ? s.slice(7) : s;
  }

  Component.onCompleted: {
    Quickshell.execDetached(["mkdir", "-p", `${shellConfigFolder}`]);
    Quickshell.execDetached(["mkdir", "-p", `${trimFileProtocol(wallpaperPath)}`]);
  }
}
