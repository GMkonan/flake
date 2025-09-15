import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Settings
import Quickshell.Widgets
import qs.Helpers

Rectangle {
    id: systemWidget
    width: 440
    height: 80
    color: "transparent"
    anchors.horizontalCenterOffset: -2

    Rectangle {
        id: card
        anchors.fill: parent
        color: Theme.surface
        radius: 18

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 12

            // User Info Row
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                // Profile Image
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: Theme.accentPrimary

                    // Border overlay
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        radius: 24
                        border.color: Theme.accentPrimary
                        border.width: 2
                        z: 2
                    }
                    ClippingWrapperRectangle {
                        radius: 32
                        width: 48
                        height: 48
                        Image {
                            id: avatarImage
                            anchors.fill: parent
                            source: Settings.profileImage !== undefined ? Settings.profileImage : ""
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            cache: false
                        }
                    }

                    // Fallback icon
                    Text {
                        anchors.centerIn: parent
                        text: "person"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 24
                        color: Theme.onAccent
                        visible: Settings.profileImage === undefined || Settings.profileImage === ""
                        z: 0
                    }
                }

                // User Info
                ColumnLayout {
                    spacing: 4
                    Layout.fillWidth: true

                    Text {
                        text: Quickshell.env("USER")
                        font.pixelSize: 16
                        font.bold: true
                        color: Theme.textPrimary
                    }

                    Text {
                        text: "System Uptime: " + uptimeText
                        font.pixelSize: 12
                        color: Theme.textSecondary
                    }
                }

                // Spacer to push button to the right
                Item {
                    Layout.fillWidth: true
                }

                // System Menu Button - positioned all the way to the right
                Rectangle {
                    id: systemButton
                    width: 32
                    height: 32
                    radius: 16
                    color: systemButtonArea.containsMouse || systemButtonArea.pressed ? Theme.accentPrimary : "transparent"
                    border.color: Theme.accentPrimary
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "power_settings_new"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 16
                        color: systemButtonArea.containsMouse || systemButtonArea.pressed ? Theme.backgroundPrimary : Theme.accentPrimary
                    }

                    MouseArea {
                        id: systemButtonArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            systemMenu.visible = !systemMenu.visible;
                        }
                    }
                }
            }
        }
    }

    // System Menu Popup - positioned below the button
    Rectangle {
        id: systemMenu
        width: 160
        height: 180
        color: Theme.surface
        radius: 8
        border.color: Theme.outline
        border.width: 1
        visible: false
        z: 9999

        // Position relative to the system button using absolute positioning
        x: systemButton.x + systemButton.width - width + 12
        y: systemButton.y + systemButton.height + 32

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 4

            // Lock Button
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 6
                color: lockButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "lock_outline"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 16
                        color: lockButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                    }

                    Text {
                        text: "Lock Screen"
                        font.pixelSize: 14
                        color: lockButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                MouseArea {
                    id: lockButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        lockScreen.locked = true;
                        systemMenu.visible = false;
                    }
                }
            }

            // Reboot Button
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 6
                color: rebootButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "refresh"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 16
                        color: rebootButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                    }

                    Text {
                        text: "Reboot"
                        font.pixelSize: 14
                        color: rebootButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                MouseArea {
                    id: rebootButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Processes.reboot();
                        systemMenu.visible = false;
                    }
                }
            }

            // Logout Button
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 6
                color: logoutButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "exit_to_app"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 16
                        color: logoutButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                    }

                    Text {
                        text: "Logout"
                        font.pixelSize: 14
                        color: logoutButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                MouseArea {
                    id: logoutButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Processes.logout();
                        systemMenu.visible = false;
                    }
                }
            }

            // Shutdown Button
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 6
                color: shutdownButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "power_settings_new"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 16
                        color: shutdownButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                    }

                    Text {
                        text: "Shutdown"
                        font.pixelSize: 14
                        color: shutdownButtonArea.containsMouse ? Theme.onAccent : Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                MouseArea {
                    id: shutdownButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Processes.shutdown();
                        systemMenu.visible = false;
                    }
                }
            }
        }

        // Close menu when clicking outside
        MouseArea {
            anchors.fill: parent
            enabled: systemMenu.visible
            onClicked: systemMenu.visible = false
            z: -1 // Put this behind other elements
        }
    }

    // Properties
    property string uptimeText: "--:--"

    // Process to get uptime
    Process {
        id: uptimeProcess
        command: ["sh", "-c", "uptime | awk -F 'up ' '{print $2}' | awk -F ',' '{print $1}' | xargs"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                uptimeText = this.text.trim();
                uptimeProcess.running = false;
            }
        }
    }

    property bool panelVisible: false

    // Trigger initial update when panel becomes visible
    onPanelVisibleChanged: {
        if (panelVisible) {
            updateSystemInfo();
        }
    }

    // Timer to update uptime - only runs when panel is visible
    Timer {
        interval: 60000 // Update every minute
        repeat: true
        running: panelVisible
        onTriggered: updateSystemInfo()
    }

    Component.onCompleted: {
        // Don't update system info immediately - wait for panel to be visible
        // updateSystemInfo() will be called when panelVisible becomes true
        uptimeProcess.running = true;
    }

    function updateSystemInfo() {
        uptimeProcess.running = true;
    }
}
