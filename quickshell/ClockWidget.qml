import QtQuick

Text {
  text: Time.time

  color: root.colGreen
  font {
    pixelSize: root.fontSize
    letterSpacing: 0.2
    family: root.fontFamily
    bold: true
  }
}
