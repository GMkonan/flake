import QtQuick
import Quickshell
import qs.Components
import qs.Settings

Item {
    id: activeWindowWrapper
    width: parent.width
    property int fullHeight: activeWindowTitleContainer.height

    y: panel.activeWindowVisible ? barBackground.height : barBackground.height - fullHeight
    height: panel.activeWindowVisible ? fullHeight : 1
    opacity: panel.activeWindowVisible ? 1 : 0
    clip: true

    Behavior on height {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutQuad
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutQuad
        }
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    Rectangle {
        id: activeWindowTitleContainer
        color: Theme.backgroundPrimary
        bottomLeftRadius: Math.max(0, width / 2)
        bottomRightRadius: Math.max(0, width / 2)

        width: Math.min(barBackground.width - 200, activeWindowTitle.implicitWidth + 24)
        height: activeWindowTitle.implicitHeight + 12

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: activeWindowTitle
            text: panel.displayedWindowTitle && panel.displayedWindowTitle.length > 60 ? panel.displayedWindowTitle.substring(0, 60) + "..." : panel.displayedWindowTitle
            font.pixelSize: 12
            color: Theme.textSecondary
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            anchors.margins: 6
            maximumLineCount: 1
        }
    }

    Corners {
        id: activeCornerRight
        position: "bottomleft"
        size: 1.1
        fillColor: Theme.backgroundPrimary
        offsetX: activeWindowTitleContainer.x + activeWindowTitleContainer.width - 33
        offsetY: 0
        anchors.top: activeWindowTitleContainer.top
    }

    Corners {
        id: activeCornerLeft
        position: "bottomright"
        size: 1.1
        fillColor: Theme.backgroundPrimary
        anchors.top: activeWindowTitleContainer.top
        x: activeWindowTitleContainer.x + 33 - width
        offsetY: 0
    }
}
