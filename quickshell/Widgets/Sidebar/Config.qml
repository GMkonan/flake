import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.Settings

Rectangle {
    id: settingsModal
    anchors.centerIn: parent
    color: Settings.Theme.backgroundPrimary
    radius: 20
    visible: false
    z: 100

    // Local properties for editing (not saved until apply)
    property string tempWeatherCity: Settings.weatherCity
    property bool tempUseFahrenheit: false
    property string tempProfileImage: Settings.profileImage
    property string tempWallpaperFolder: Settings.wallpaperFolder

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Text {
                text: "settings"
                font.family: "Material Symbols Outlined"
                font.pixelSize: 28
                color: Settings.Theme.accentPrimary
            }

            Text {
                text: "Settings"
                font.pixelSize: 22
                font.bold: true
                color: Settings.Theme.textPrimary
                Layout.fillWidth: true
            }

            Rectangle {
                width: 36
                height: 36
                radius: 18
                color: closeButtonArea.containsMouse ? Settings.Theme.accentPrimary : "transparent"
                border.color: Settings.Theme.accentPrimary
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "close"
                    font.family: "Material Symbols Outlined"
                    font.pixelSize: 18
                    color: closeButtonArea.containsMouse ? Settings.Theme.onAccent : Settings.Theme.accentPrimary
                }

                MouseArea {
                    id: closeButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: settingsModal.closeSettings()
                }
            }
        }

        // Weather Settings Card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 180
            color: Settings.Theme.surface
            radius: 18

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 12

                // Weather Settings Header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Text {
                        text: "wb_sunny"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Settings.Theme.accentPrimary
                    }

                    Text {
                        text: "Weather Settings"
                        font.pixelSize: 16
                        font.bold: true
                        color: Settings.Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                // Weather City Setting
                ColumnLayout {
                    spacing: 8
                    Layout.fillWidth: true

                    Text {
                        text: "City"
                        font.pixelSize: 13
                        font.bold: true
                        color: Settings.Theme.textPrimary
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        radius: 8
                        color: Settings.Theme.surfaceVariant
                        border.color: cityInput.activeFocus ? Settings.Theme.accentPrimary : Settings.Theme.outline
                        border.width: 1

                        TextInput {
                            id: cityInput
                            anchors.fill: parent
                            anchors.margins: 12
                            text: tempWeatherCity
                            font.pixelSize: 13
                            color: Settings.Theme.textPrimary
                            verticalAlignment: TextInput.AlignVCenter
                            clip: true
                            focus: true
                            selectByMouse: true
                            activeFocusOnTab: true
                            inputMethodHints: Qt.ImhNone

                            onTextChanged: {
                                tempWeatherCity = text;
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    cityInput.forceActiveFocus();
                                }
                            }
                        }
                    }
                }

                // Temperature Unit Setting
                RowLayout {
                    spacing: 12
                    Layout.fillWidth: true

                    Text {
                        text: "Temperature Unit"
                        font.pixelSize: 13
                        font.bold: true
                        color: Settings.Theme.textPrimary
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    // Custom Material 3 Switch
                    Rectangle {
                        id: customSwitch
                        width: 52
                        height: 32
                        radius: 16
                        color: Settings.Theme.accentPrimary
                        border.color: Settings.Theme.accentPrimary
                        border.width: 2

                        Rectangle {
                            id: thumb
                            width: 28
                            height: 28
                            radius: 14
                            color: Settings.Theme.surface
                            border.color: Settings.Theme.outline
                            border.width: 1
                            y: 2
                            x: tempUseFahrenheit ? customSwitch.width - width - 2 : 2

                            Text {
                                anchors.centerIn: parent
                                text: tempUseFahrenheit ? "°F" : "°C"
                                font.pixelSize: 12
                                font.bold: true
                                color: Settings.Theme.textPrimary
                            }

                            Behavior on x {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                tempUseFahrenheit = !tempUseFahrenheit;
                            }
                        }
                    }
                }
            }
        }

        // Profile Image Card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 140
            color: Settings.Theme.surface
            radius: 18
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 0
            border.color: "transparent"
            border.width: 0
            Layout.bottomMargin: 16

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 12

                // Profile Image Header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Text {
                        text: "person"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Settings.Theme.accentPrimary
                    }

                    Text {
                        text: "Profile Image"
                        font.pixelSize: 16
                        font.bold: true
                        color: Settings.Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                // Profile Image Input Row
                RowLayout {
                    spacing: 8
                    Layout.fillWidth: true

                    Rectangle {
                        width: 36
                        height: 36
                        radius: 18
                        color: Settings.Theme.surfaceVariant
                        border.color: profileImageInput.activeFocus ? Settings.Theme.accentPrimary : Settings.Theme.outline
                        border.width: 1

                        Image {
                            id: avatarImage
                            anchors.fill: parent
                            anchors.margins: 2
                            source: tempProfileImage
                            fillMode: Image.PreserveAspectCrop
                            visible: false
                            asynchronous: true
                        }
                        // Fallback icon
                        Text {
                            anchors.centerIn: parent
                            text: "person"
                            font.family: "Material Symbols Outlined"
                            font.pixelSize: 18
                            color: Settings.Theme.accentPrimary
                            visible: tempProfileImage === ""
                        }
                    }

                    // Text input styled exactly like weather city
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        radius: 8
                        color: Settings.Theme.surfaceVariant
                        border.color: profileImageInput.activeFocus ? Settings.Theme.accentPrimary : Settings.Theme.outline
                        border.width: 1

                        TextInput {
                            id: profileImageInput
                            anchors.fill: parent
                            anchors.margins: 12
                            text: tempProfileImage
                            font.pixelSize: 13
                            color: Settings.Theme.textPrimary
                            verticalAlignment: TextInput.AlignVCenter
                            clip: true
                            focus: true
                            selectByMouse: true
                            activeFocusOnTab: true
                            inputMethodHints: Qt.ImhNone
                            onTextChanged: {
                                tempProfileImage = text;
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    profileImageInput.forceActiveFocus();
                                }
                            }
                        }
                    }
                }
            }
        }

        // Wallpaper Folder Card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: Settings.Theme.surface
            radius: 18

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 12

                // Header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12
                    Text {
                        text: "image"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Settings.Theme.accentPrimary
                    }
                    Text {
                        text: "Wallpaper Folder"
                        font.pixelSize: 16
                        font.bold: true
                        color: Settings.Theme.textPrimary
                        Layout.fillWidth: true
                    }
                }

                // Folder Path Input
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 36
                    radius: 8
                    color: Settings.Theme.surfaceVariant
                    border.color: wallpaperFolderInput.activeFocus ? Settings.Theme.accentPrimary : Settings.Theme.outline
                    border.width: 1

                    TextInput {
                        id: wallpaperFolderInput
                        anchors.fill: parent
                        anchors.margins: 12
                        text: tempWallpaperFolder
                        font.pixelSize: 13
                        color: Settings.Theme.textPrimary
                        verticalAlignment: TextInput.AlignVCenter
                        clip: true
                        selectByMouse: true
                        activeFocusOnTab: true
                        inputMethodHints: Qt.ImhUrlCharactersOnly
                        onTextChanged: tempWallpaperFolder = text
                        MouseArea {
                            anchors.fill: parent
                            onClicked: wallpaperFolderInput.forceActiveFocus()
                        }
                    }
                }
            }
        }

        // Spacer to push content to top
        Item {
            Layout.fillHeight: true
        }

        // Apply Button
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            radius: 12
            color: applyButtonArea.containsMouse ? Settings.Theme.accentPrimary : Settings.Theme.accentPrimary
            border.color: "transparent"
            border.width: 0
            opacity: 1.0

            Text {
                anchors.centerIn: parent
                text: "Apply Changes"
                font.pixelSize: 15
                font.bold: true
                color: applyButtonArea.containsMouse ? Settings.Theme.onAccent : Settings.Theme.onAccent
            }

            MouseArea {
                id: applyButtonArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    // Apply the changes
                    Settings.weatherCity = tempWeatherCity;
                    Settings.useFahrenheit = tempUseFahrenheit;
                    Settings.profileImage = tempProfileImage;
                    Settings.wallpaperFolder = tempWallpaperFolder;
                    // Force save settings
                    Settings.saveSettings();
                    // Refresh weather if available
                    if (typeof weather !== 'undefined' && weather) {
                        weather.fetchCityWeather();
                    }
                    // Close the modal
                    settingsModal.closeSettings();
                }
            }
        }
    }

    // Function to open the modal and initialize temp values
    function openSettings() {
        tempWeatherCity = Settings.weatherCity;
        tempUseFahrenheit = Settings.useFahrenheit;
        tempProfileImage = Settings.profileImage;
        tempWallpaperFolder = Settings.wallpaperFolder;
        visible = true;
        // Force focus on the text input after a short delay
        focusTimer.start();
    }

    // Function to close the modal and release focus
    function closeSettings() {
        visible = false;
        cityInput.focus = false;
        profileImageInput.focus = false;
        wallpaperFolderInput.focus = false;
    }

    Timer {
        id: focusTimer
        interval: 100
        repeat: false
        onTriggered: {
            if (visible) {
                cityInput.forceActiveFocus();
                // Optionally, also focus profileImageInput if you want both to get focus:
                // profileImageInput.forceActiveFocus()
            }
        }
    }

    // Release focus when modal becomes invisible
    onVisibleChanged: {
        if (!visible) {
            cityInput.focus = false;
            profileImageInput.focus = false;
            wallpaperFolderInput.focus = false;
        }
    }
}
