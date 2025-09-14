import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs.Settings
import qs.Components

Item {
    id: bluetoothDisplay
    width: 22
    height: 22

    property color hoverColor: Theme.rippleEffect
    property real hoverOpacity: 0.0
    property bool isActive: mouseArea.containsMouse || (bluetoothPopup && bluetoothPopup.visible)

    // Show the Bluetooth popup when clicked
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: {
            if (bluetoothPopup.visible) {
                bluetoothPopup.hidePopup();
            } else {
                bluetoothPopup.showAt(this, 0, parent.height);
            }
        }
        onEntered: bluetoothDisplay.hoverOpacity = 0.18
        onExited: bluetoothDisplay.hoverOpacity = 0.0
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -4  // Make hover area larger than icon
        color: hoverColor
        opacity: isActive ? 0.18 : hoverOpacity
        radius: height / 2
        z: 0
        visible: opacity > 0.01
    }

    Text {
        anchors.centerIn: parent
        text: "bluetooth"
        font.family: isActive ? "Material Symbols Rounded" : "Material Symbols Outlined"
        font.pixelSize: 18
        color: bluetoothPopup.visible ? Theme.accentPrimary : Theme.textPrimary
        z: 1
    }

    Behavior on hoverOpacity {
        NumberAnimation {
            duration: 120
            easing.type: Easing.OutQuad
        }
    }

    // The popup window for device list
    PopupWindow {
        id: bluetoothPopup
        implicitWidth: 350
        //property int deviceCount: (typeof Bluetooth.devices.count === 'number' && Bluetooth.devices.count >= 0) ? Bluetooth.devices.count : 0
        //implicitHeight: Math.max(100, Math.min(420, 56 + (deviceCount * 36) + 24))
        implicitHeight: 400
        visible: false
        color: "transparent"

        property var anchorItem: null
        property real anchorX
        property real anchorY

        anchor.item: anchorItem ? anchorItem : null
        anchor.rect.x: anchorX - (implicitWidth / 2) + (anchorItem ? anchorItem.width / 2 : 0)
        anchor.rect.y: anchorY + 8 // Move popup further down

        function showAt(item, x, y) {
            if (!item) {
                console.warn("Bluetooth: anchorItem is undefined, not showing popup.");
                return;
            }
            anchorItem = item;
            anchorX = x;
            anchorY = y;
            visible = true;
            forceActiveFocus();
        }

        function hidePopup() {
            visible = false;
        }

        Item {
            anchors.fill: parent
            Keys.onEscapePressed: bluetoothPopup.hidePopup()
        }

        Rectangle {
            id: bg
            anchors.fill: parent
            color: Theme.backgroundPrimary
            radius: 12
            border.width: 1
            border.color: Theme.surfaceVariant
            z: 0
        }

        // Header
        Rectangle {
            id: header
            width: parent.width
            height: 56
            color: "transparent"

            Text {
                text: "Bluetooth"
                font.pixelSize: 18
                font.bold: true
                color: Theme.textPrimary
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 16
            }
        }

        // Device list container with proper margins
        Rectangle {
            id: listContainer
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 8
            color: "transparent"
            clip: true

            ListView {
                id: deviceListView
                anchors.fill: parent
                spacing: 4
                boundsBehavior: Flickable.StopAtBounds
                model: Bluetooth.devices
                delegate: Rectangle {
                    width: parent.width
                    height: 42
                    color: "transparent"
                    radius: 8

                    Rectangle {
                        anchors.fill: parent
                        radius: 8
                        color: modelData.connected ? Qt.rgba(Theme.accentPrimary.r, Theme.accentPrimary.g, Theme.accentPrimary.b, 0.18) : (deviceMouseArea.containsMouse ? Theme.highlight : "transparent")
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12

                        Text {
                            text: modelData.connected ? "bluetooth" : "bluetooth_disabled"
                            font.family: "Material Symbols Outlined"
                            font.pixelSize: 20
                            color: modelData.connected ? Theme.accentPrimary : Theme.textSecondary
                            verticalAlignment: Text.AlignVCenter
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                text: modelData.name || "Unknown Device"
                                color: modelData.connected ? Theme.accentPrimary : Theme.textPrimary
                                font.pixelSize: 14
                                elide: Text.ElideRight
                            }

                            Text {
                                text: modelData.address
                                color: modelData.connected ? Theme.accentPrimary : Theme.textSecondary
                                font.pixelSize: 11
                                elide: Text.ElideRight
                            }
                        }
                    }

                    MouseArea {
                        id: deviceMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (modelData.connected) {
                                modelData.disconnect();
                            } else {
                                modelData.connect();
                            }
                        }
                    }
                }
            }
        }

        // Scroll indicator when needed
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.top: listContainer.top
            anchors.bottom: listContainer.bottom
            width: 4
            radius: 2
            color: Theme.textSecondary
            opacity: deviceListView.contentHeight > deviceListView.height ? 0.3 : 0
            visible: opacity > 0
        }
    }
}
