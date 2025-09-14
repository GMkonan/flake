import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Quickshell
import Quickshell.Wayland
import qs.Settings

PanelWindow {
    id: settingsModal
    implicitWidth: 480
    implicitHeight: 720
    visible: false
    color: "transparent"
    anchors.top: true
    anchors.right: true
    margins.right: 0
    margins.top: -24
    //z: 100
    //border.color: Theme.outline
    //border.width: 1
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    // Local properties for editing (not saved until apply)
    property string tempWeatherCity: (Settings.weatherCity !== undefined && Settings.weatherCity !== null) ? Settings.weatherCity : ""
    property bool tempUseFahrenheit: Settings.useFahrenheit
    property string tempProfileImage: (Settings.profileImage !== undefined && Settings.profileImage !== null) ? Settings.profileImage : ""
    property string tempWallpaperFolder: (Settings.wallpaperFolder !== undefined && Settings.wallpaperFolder !== null) ? Settings.wallpaperFolder : ""

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundPrimary
        radius: 24
        //border.color: Theme.outline
        //border.width: 1
        z: 0

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 32
            spacing: 24

            // Header
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 20
                    Text {
                        text: "settings"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 32
                        color: Theme.accentPrimary
                    }
                    Text {
                        text: "Settings"
                        font.pixelSize: 26
                        font.bold: true
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }
                    Rectangle {
                        width: 36
                        height: 36
                        radius: 18
                        color: closeButtonArea.containsMouse ? Theme.accentPrimary : "transparent"
                        border.color: Theme.accentPrimary
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            text: "close"
                            font.family: closeButtonArea.containsMouse ? "Material Symbols Rounded" : "Material Symbols Outlined"
                            font.pixelSize: 20
                            color: closeButtonArea.containsMouse ? Theme.onAccent : Theme.accentPrimary
                        }
                        MouseArea {
                            id: closeButtonArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: settingsModal.closeSettings()
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Theme.outline
                    opacity: 0.12
                }
            }

            // Scrollable settings area
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 520
                color: "transparent"
                border.width: 0
                radius: 20
                Flickable {
                    id: flick
                    anchors.fill: parent
                    contentWidth: width
                    contentHeight: column.implicitHeight
                    clip: true
                    interactive: true
                    boundsBehavior: Flickable.StopAtBounds
                    ColumnLayout {
                        id: column
                        width: flick.width
                        spacing: 24
                        // CollapsibleCategory sections here
                        CollapsibleCategory {
                            title: "Weather"
                            expanded: false
                            WeatherSettings {
                                weatherCity: (typeof tempWeatherCity !== 'undefined' && tempWeatherCity !== null) ? tempWeatherCity : ""
                                useFahrenheit: tempUseFahrenheit
                                onCityChanged: function (city) {
                                    tempWeatherCity = city;
                                }
                                onTemperatureUnitChanged: function (useFahrenheit) {
                                    tempUseFahrenheit = useFahrenheit;
                                }
                            }
                        }
                        CollapsibleCategory {
                            title: "System"
                            expanded: false
                            ProfileSettings {}
                        }
                        CollapsibleCategory {
                            title: "Wallpaper"
                            expanded: false
                            WallpaperSettings {
                                wallpaperFolder: (typeof tempWallpaperFolder !== 'undefined' && tempWallpaperFolder !== null) ? tempWallpaperFolder : ""
                                onWallpaperFolderEdited: function (folder) {
                                    tempWallpaperFolder = folder;
                                }
                            }
                        }
                    }
                }
            }

            // Apply Button
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 52
                radius: 16
                color: applyButtonArea.containsMouse ? Theme.accentPrimary : Theme.accentPrimary
                border.color: "transparent"
                border.width: 0
                opacity: 1.0
                Text {
                    anchors.centerIn: parent
                    text: "Apply Changes"
                    font.pixelSize: 17
                    font.bold: true
                    color: applyButtonArea.containsMouse ? Theme.onAccent : Theme.onAccent
                }
                MouseArea {
                    id: applyButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Settings.weatherCity = (typeof tempWeatherCity !== 'undefined' && tempWeatherCity !== null) ? tempWeatherCity : "";
                        Settings.useFahrenheit = tempUseFahrenheit;
                        Settings.profileImage = (typeof tempProfileImage !== 'undefined' && tempProfileImage !== null) ? tempProfileImage : "";
                        Settings.wallpaperFolder = (typeof tempWallpaperFolder !== 'undefined' && tempWallpaperFolder !== null) ? tempWallpaperFolder : "";
                        Settings.saveSettings();
                        if (typeof weather !== 'undefined' && weather) {
                            weather.fetchCityWeather();
                        }
                        settingsModal.closeSettings();
                    }
                }
            }
        }
    }

    // Function to open the modal and initialize temp values
    function openSettings() {
        tempWeatherCity = (Settings.weatherCity !== undefined && Settings.weatherCity !== null) ? Settings.weatherCity : "";
        tempUseFahrenheit = Settings.useFahrenheit;
        tempProfileImage = (Settings.profileImage !== undefined && Settings.profileImage !== null) ? Settings.profileImage : "";
        tempWallpaperFolder = (Settings.wallpaperFolder !== undefined && Settings.wallpaperFolder !== null) ? Settings.wallpaperFolder : "";
        if (tempWallpaperFolder === undefined || tempWallpaperFolder === null)
            tempWallpaperFolder = "";
        visible = true;
        // Force focus on the text input after a short delay
        focusTimer.start();
    }

    // Function to close the modal and release focus
    function closeSettings() {
        visible = false;
    }

    Timer {
        id: focusTimer
        interval: 100
        repeat: false
        onTriggered: {
            if (visible)
            // Focus will be handled by the individual components
            {}
        }
    }

    // Release focus when modal becomes invisible
    onVisibleChanged: {
        if (!visible)
        // Focus will be handled by the individual components
        {}
    }
}
