import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Io
import Quickshell.Wayland

import qs.modules.common
import qs.modules.config
import qs.services

StyledRect {
	id: root
	required property LockContext context

  Image {
    id: wallpaper
    visible: Wallpaper.imagePath.length !== 0
    anchors.fill: parent
    source: Wallpaper.imagePath
    fillMode: Image.PreserveAspectFit
    asynchronous: true

    layer {
      enabled: true
      effect: MultiEffect {
        colorization: 0.4
        colorizationColor: Colors.shadow

        blurEnabled: true
        blurMultiplier: 1
        blurMax: 32
        blur: 0.8
      }
    }

    NumberAnimation on opacity {
      from: 0
      to: 1
      duration: 1000
      easing.type: Easing.InCubic
    }
  }

  RowLayout {
    anchors.centerIn: parent
    spacing: 200

    ColumnLayout {
      StyledText {
        id: time
        Layout.fillWidth: true
        Layout.leftMargin: -8

        font {
          family: "Roboto Flex"
          weight: Font.Black
          variableAxes: { "wdth": 150 }
          pixelSize: 80
        }

        renderType: Text.NativeRendering

        text: Time.getTime("h:mm AP")
      }

      StyledText {
        font {
          bold: true
          variableAxes: { "wdth": 150 }
        }

        renderType: Text.NativeRendering
        opacity: 0.8
        font.pixelSize: 16

        text: Time.getTime("ddd, MMMM d, yyyy")
      }
    }

    Rectangle {
      Layout.preferredWidth: 2
      Layout.preferredHeight: parent.height
      Layout.alignment: Qt.AlignVCenter
      Layout.leftMargin: 2
      Layout.rightMargin: 2
      opacity: 0.85
      color: Colors.onPrimary
    }

    ColumnLayout {
      // Uncommenting this will make the password entry invisible except on the active monitor.
      // visible: Window.active

      StyledText {
        visible: SystemInfo.user.length !== 0

        font {
          family: "Roboto Flex"
          weight: Font.Black
          variableAxes: { "wdth": 150 }
        }

        color: Colors.uponPrimaryContainer

        renderType: Text.NativeRendering
        font.pixelSize: 70

        text: SystemInfo.user
      }

      RowLayout {
        TextField {
          id: passwordBox

          implicitWidth: 400
          padding: 10

          focus: true
          enabled: !root.context.unlockInProgress
          echoMode: TextInput.Password
          inputMethodHints: Qt.ImhSensitiveData

          placeholderText: "Password"

          // Update the text in the context when the text in the box changes.
          onTextChanged: root.context.currentText = this.text;

          // Try to unlock when enter is pressed.
          onAccepted: root.context.tryUnlock();
          background: Rectangle {
            id: textBox
            radius: 8
            color: passwordBox.enabled ? Qt.rgba(0, 0, 0, 0.2) : "transparent"
            border.width: 4
            border.color: Colors.onPrimary

            layer {
              enabled: true
              effect: MultiEffect {
                shadowColor: Colors.shadow
                shadowEnabled: true
                blurEnabled: true
                brightness: 0.4
                blurMax: 64
                blur: 0.1
              }
            }
          }

          // Update the text in the box to match the text in the context.
          // This makes sure multiple monitors have the same text.
          Connections {
            target: root.context

            function onCurrentTextChanged() {
              passwordBox.text = root.context.currentText;
            }
          }
        }

        Button {
          id: unlockButton
          text: "Unlock"
          padding: 15

          focusPolicy: Qt.NoFocus

          contentItem: Text {
            text: unlockButton.text

            font.family: "Roboto Flex"

            opacity: enabled ? 1.0 : 0.3
            color: Colors.fg
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
          }

          background: Rectangle {
            color: unlockButton.down ? Colors.inversePrimary : Colors.onSecondaryFixed
            radius: 8
          }

          enabled: !root.context.unlockInProgress && root.context.currentText !== "";
          onClicked: root.context.tryUnlock();
        }
      }

      Label {
        visible: root.context.showFailure
        text: "Incorrect password"
      }
    }
  }

  Button {
    text: 'ge tout'
    onClicked: root.context.unlocked();
  }

  Keys.onPressed: (event) => {
    if (event.key == Qt.Key_Escape) {
      root.context.unlocked();
      event.accepted = true;
    }
  }
}

