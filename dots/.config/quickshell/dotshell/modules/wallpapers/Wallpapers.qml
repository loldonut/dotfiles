import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel
import Qt.labs.platform
import QtQml
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.modules.config

Scope {
  id: root
  property bool openWallpaper: false

  IpcHandler {
    target: "wallpapers"
    function toggle() : void { root.openWallpaper = !root.openWallpaper }
    function show() : void { root.openWallpaper = true }
    function hide() : void { root.openWallpaper = false }
  }

  FolderListModel {
    id: wallpaperModel
    folder: StandardPaths.writableLocation(StandardPaths.HomeLocation) + "/Pictures/Wallpapers"
    nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp"]
    showDirs: false
  }

  Process {
    id: matugenProc
    stdout: StdioCollector {
      onStreamFinished: console.log(`line read: ${this.text}`)
    }
    stderr: StdioCollector {
      onStreamFinished: console.log(`line read: ${this.text}`)
    }
    onExited: code => {
      console.log(code)
    }
  }

  PanelWindow {
    visible: root.openWallpaper
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    implicitWidth: 650
    implicitHeight: 500

    onVisibleChanged: {
      if (visible) {
        container.forceActiveFocus()
      }
    }

    Rectangle {
      id: container
      anchors.fill: parent
      color: Colors.bg
      radius: 12
      border.width: 2
      border.color: Colors.fg

      Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Escape) {
          root.openWallpaper = false
          event.accepted = true
        }
      }

      ColumnLayout {
        id: centerCol
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        RowLayout {
          Layout.fillWidth: true

          Text {
            Layout.fillWidth: true
            anchors.centerIn: parent
            font.family: Config.fontConfig.family
            font.pixelSize: Config.fontConfig.size
            color: Colors.fg
            text: "Select wallpaper"
          }
        }

        Rectangle {
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: 1.5
          Layout.alignment: Qt.AlignVCenter
          Layout.leftMargin: 2
          Layout.rightMargin: 2
          opacity: 0.3
          color: Colors.fg
        }

        Item {
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true

          GridView {
            id: wallpaperGrid
            anchors.fill: parent
            model: wallpaperModel

            cellWidth: 155
            cellHeight: 105

            delegate: Item {
              id: delegateItem
              width: wallpaperGrid.cellWidth
              height: wallpaperGrid.cellHeight

              DropShadow {
                anchors.fill: cardContainer
                horizontalOffset: 0
                verticalOffset: 0
                radius: 8
                samples: 17
                color: mouseArea.containsMouse ? Colors.fg : "transparent"
                source: cardContainer

                Behavior on color {
                  ColorAnimation { duration: 150 }
                }
              }

              Rectangle {
                id: cardContainer
                anchors.fill: parent
                anchors.margins: 6
                color: "transparent"
                radius: 6
                clip: true

                border.width: 2
                border.color: mouseArea.containsMouse ? Colors.fg : Colors.onPrimary

                Behavior on border.color {
                  ColorAnimation { duration: 300 }
                }

                Image {
                  id: wallpaperImage
                  anchors.fill: parent
                  anchors.margins: 2
                  source: fileUrl
                  fillMode: Image.PreserveAspectCrop
                  asynchronous: true
                }
              }

              MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                  console.log("Selected wallpaper:", filePath)
                  root.openWallpaper = false
                  if (matugenProc.running) {
                    matugenProc.running = false
                  }
                  matugenProc.command = ["matugen", "image", filePath, "--source-color-index", "0"]
                  matugenProc.running = true
                }
              }
            }
          }
        }
      }
    }
  }
}

