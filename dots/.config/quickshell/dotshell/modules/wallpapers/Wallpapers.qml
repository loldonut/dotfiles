import Qt.labs.folderlistmodel
import Qt5Compat.GraphicalEffects
import QtQml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import qs.modules.common
import qs.modules.config
import qs.services

Scope {
  id: root
  property bool openWallpaper: false

  IpcHandler {
    target: "wallpapers"
    function toggle(): void {
      root.openWallpaper = !root.openWallpaper;
    }
    function show(): void {
      root.openWallpaper = true;
    }
    function hide(): void {
      root.openWallpaper = false;
    }
  }

  FolderListModel {
    id: wallpaperModel
    folder: Paths.wallpaperPath
    nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp"]
    showDirs: false
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

    onVisibleChanged: {
      if (visible) {
        container.forceActiveFocus();
      }
    }

    Rectangle {
      anchors.fill: parent

      opacity: 0.35
      color: "black"
    }

    MouseArea {
      anchors.fill: parent
      onClicked: root.openWallpaper = false
    }

    Rectangle {
      id: container

      anchors.centerIn: parent

      implicitWidth: 680
      implicitHeight: 500

      color: Colors.md3.surface
      radius: 12
      border.width: 2
      border.color: Colors.md3.inverse_primary

      Keys.onPressed: event => {
        if (event.key === Qt.Key_Escape) {
          root.openWallpaper = false;
          event.accepted = true;
        }
      }

      ColumnLayout {
        id: centerCol
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        RowLayout {
          Layout.fillWidth: true

          StyledText {
            Layout.alignment: Qt.AlignVCenter
            font {
              pixelSize: Config.font.size + 4
              weight: Font.Black
              variableAxes: {
                "wdth": 150
              }
            }
            color: Colors.md3.primary
            text: "Wallpapers"
          }
        }

        Rectangle {
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: 1.5
          Layout.alignment: Qt.AlignVCenter
          Layout.leftMargin: 2
          Layout.rightMargin: 2
          opacity: 0.2
          color: Colors.md3.primary
        }

        Item {
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true

          GridView {
            id: wallpaperGrid
            anchors.fill: parent
            model: wallpaperModel

            cellWidth: 160
            cellHeight: 110

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
                color: mouseArea.containsMouse ? Colors.md3.primary : "transparent"
                source: cardContainer

                Behavior on color {
                  ColorAnimation {
                    duration: 150
                  }
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
                border.color: mouseArea.containsMouse ? Colors.md3.primary : Colors.md3.on_primary

                Behavior on border.color {
                  ColorAnimation {
                    duration: 300
                  }
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
                  root.openWallpaper = false;
                  Wallpaper.setImage(filePath);
                }
              }
            }
          }
        }
      }
    }
  }
}
