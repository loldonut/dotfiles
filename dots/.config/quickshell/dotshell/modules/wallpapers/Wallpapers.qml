import Qt.labs.folderlistmodel
import Qt.labs.platform
import Qt5Compat.GraphicalEffects
import QtQml
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import qs.modules.common
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
    folder: Config.bar.wallpaperPath
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

    anchors {
      top: true
      bottom: true
      left: true
      right: true
    }

    implicitWidth: 650
    implicitHeight: 500

    onVisibleChanged: {
      if (visible) {
        container.forceActiveFocus()
      }
    }

    RectangularShadow {
      anchors.fill: parent

      blur: 24
      spread: 0.05
      color: Qt.rgba(0, 0, 0, 0.6)
    }

    MouseArea {
      anchors.fill: parent
      onClicked: root.openWallpaper = false
    }

    Rectangle {
      id: container
      anchors.centerIn: parent
      color: Colors.bg
      radius: 12
      height: 500
      width: 650
      border.width: 2
      border.color: Colors.inversePrimary

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

          StyledText {
            Layout.alignment: Qt.AlignVCenter
            font {
              pixelSize: Config.font.size + 4
            }
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

