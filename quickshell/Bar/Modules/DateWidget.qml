import QtQuick
import qs.Settings

Rectangle {
    width: textItem.paintedWidth
    height: textItem.paintedHeight
    color: "transparent"

    Text {
        id: textItem
        text: Date.date
        font.family: "Roboto"
        font.weight: Font.Bold
        font.pixelSize: 14
        color: Theme.textPrimary
        anchors.centerIn: parent
    }
}