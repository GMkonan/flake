import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell
import Quickshell.Services.Pam
import Quickshell.Io
import qs.Settings
import qs.Helpers
import Quickshell.Widgets
import "../Helpers/Weather.js" as WeatherHelper

// Password-only lockscreen for all screens
WlSessionLock {
    id: lock
    property string errorMessage: ""
    property bool authenticating: false
    property string password: ""
    property bool pamAvailable: typeof PamContext !== "undefined"
    property string weatherCity: Settings.weatherCity
    property var weatherData: null
    property string weatherError: ""
    property string weatherInfo: ""
    property string weatherIcon: ""
    property double currentTemp: 0
    locked: false // Start unlocked, only lock when button is clicked

    // On component completed, fetch weather data
    Component.onCompleted: {
        fetchWeatherData();
    }

    // Weather fetching function
    function fetchWeatherData() {
        WeatherHelper.fetchCityWeather(weatherCity, function (result) {
            weatherData = result.weather;
            weatherError = "";
        }, function (err) {
            weatherError = err;
        });
    }

    function materialSymbolForCode(code) {
        if (code === 0)
            return "sunny";
        if (code === 1 || code === 2)
            return "partly_cloudy_day";
        if (code === 3)
            return "cloud";
        if (code >= 45 && code <= 48)
            return "foggy";
        if (code >= 51 && code <= 67)
            return "rainy";
        if (code >= 71 && code <= 77)
            return "weather_snowy";
        if (code >= 80 && code <= 82)
            return "rainy";
        if (code >= 95 && code <= 99)
            return "thunderstorm";
        return "cloud";
    }

    // Authentication function
    function unlockAttempt() {
        console.log("Unlock attempt started");
        if (!pamAvailable) {
            lock.errorMessage = "PAM authentication not available.";
            console.log("PAM not available");
            return;
        }
        if (!lock.password) {
            lock.errorMessage = "Password required.";
            console.log("No password entered");
            return;
        }
        console.log("Starting PAM authentication...");
        lock.authenticating = true;
        lock.errorMessage = "";

        console.log("[LockScreen] About to create PAM context with userName:", Quickshell.env("USER"));
        var pam = Qt.createQmlObject('import Quickshell.Services.Pam; PamContext { config: "login"; user: "' + Quickshell.env("USER") + '" }', lock);
        console.log("PamContext created", pam);

        pam.onCompleted.connect(function (result) {
            console.log("PAM completed with result:", result);
            lock.authenticating = false;
            if (result === PamResult.Success) {
                console.log("Authentication successful, unlocking...");
                lock.locked = false;
                lock.password = "";
                lock.errorMessage = "";
            } else {
                console.log("Authentication failed");
                lock.errorMessage = "Authentication failed.";
                lock.password = "";
            }
            pam.destroy();
        });

        pam.onError.connect(function (error) {
            console.log("PAM error:", error);
            lock.authenticating = false;
            lock.errorMessage = pam.message || "Authentication error.";
            lock.password = "";
            pam.destroy();
        });

        pam.onPamMessage.connect(function () {
            console.log("PAM message:", pam.message, "isError:", pam.messageIsError);
            if (pam.messageIsError) {
                lock.errorMessage = pam.message;
            }
        });

        pam.onResponseRequiredChanged.connect(function () {
            console.log("PAM response required:", pam.responseRequired);
            if (pam.responseRequired && lock.authenticating) {
                console.log("Responding to PAM with password");
                pam.respond(lock.password);
            }
        });

        var started = pam.start();
        console.log("PAM start result:", started);
    }

    Component {
        id: lockComponent
        WlSessionLockSurface {
            // Blurred wallpaper background
            Image {
                id: lockBgImage
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: Settings.currentWallpaper !== "" ? Settings.currentWallpaper : "/home/konan/flake/wallpapers/dark/genshin-impact-girl-question-mark.jpg"
                cache: true
                smooth: true
                sourceSize.width: 2560
                sourceSize.height: 1440
                visible: true // Show the original for FastBlur input
            }
            MultiEffect {
                source: lockBgImage
                anchors.fill: parent
                visible: true
                blurEnabled: true
                blurMax: 24
                blur: 0.6
            }
            // Main content container (moved up, Rectangle removed)
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 30
                width: Math.min(parent.width * 0.8, 400)

                // User avatar/icon
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 80
                    height: 80
                    radius: 40
                    color: Theme.accentPrimary

                    Image {
                        id: avatarImage
                        anchors.fill: parent
                        anchors.margins: 4
                        source: Settings.profileImage
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                        asynchronous: true
                    }

                    MultiEffect {
                        source: avatarImage
                        anchors.fill: avatarImage
                        visible: true
                        // brightness: 0.4
                        // saturation: 0.2
                        // blurEnabled: true
                        // blurMax: 24
                        // blur: 1.0
                    }
                    // OpacityMask {
                    //     anchors.fill: avatarImage
                    //     source: avatarImage
                    //     maskSource: Rectangle {
                    //         width: avatarImage.width
                    //         height: avatarImage.height
                    //         radius: avatarImage.width / 2
                    //         visible: false
                    //     }
                    //     visible: Settings.profileImage !== ""
                    // }
                    // Fallback icon
                    Text {
                        anchors.centerIn: parent
                        text: "person"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 32
                        color: Theme.onAccent
                        visible: Settings.profileImage === ""
                    }
                    // // Glow effect
                    // layer.enabled: true
                    // layer.effect: Glow {
                    //     color: Theme.accentPrimary
                    //     radius: 8
                    //     samples: 16
                    // }
                }

                // Username
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: Quickshell.env("USER")
                    font.pixelSize: 24
                    font.weight: Font.Medium
                    color: Theme.textPrimary
                }

                // Password input container
                Rectangle {
                    Layout.fillWidth: true
                    height: 50
                    radius: 25
                    color: Theme.surface
                    opacity: 0.3
                    border.color: passwordInput.activeFocus ? Theme.accentPrimary : Theme.outline
                    border.width: 2

                    TextInput {
                        id: passwordInput
                        anchors.fill: parent
                        anchors.margins: 15
                        verticalAlignment: TextInput.AlignVCenter
                        horizontalAlignment: TextInput.AlignHCenter
                        font.pixelSize: 16
                        color: Theme.textPrimary
                        echoMode: TextInput.Password
                        passwordCharacter: "●"
                        passwordMaskDelay: 0

                        text: lock.password
                        onTextChanged: lock.password = text

                        // Placeholder text
                        Text {
                            anchors.centerIn: parent
                            text: "Enter password..."
                            color: Theme.textSecondary
                            opacity: 0.6
                            font.pixelSize: 16
                            visible: !passwordInput.text && !passwordInput.activeFocus
                        }

                        // Handle Enter key
                        Keys.onPressed: function (event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                lock.unlockAttempt();
                            }
                        }
                    }
                }

                // Error message
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: lock.errorMessage
                    color: Theme.error
                    font.pixelSize: 14
                    visible: lock.errorMessage !== ""
                    opacity: lock.errorMessage !== "" ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                }

                // Unlock button
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    width: 120
                    height: 44
                    radius: 22
                    color: unlockButtonArea.containsMouse ? Theme.accentPrimary : "transparent"
                    border.color: Theme.accentPrimary
                    border.width: 2
                    opacity: lock.authenticating ? 0.5 : 0.8
                    enabled: !lock.authenticating

                    Text {
                        anchors.centerIn: parent
                        text: lock.authenticating ? "Authenticating..." : "Unlock"
                        font.pixelSize: 16
                        font.bold: true
                        color: unlockButtonArea.containsMouse ? Theme.onAccent : Theme.accentPrimary
                    }

                    MouseArea {
                        id: unlockButtonArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (!lock.authenticating) {
                                lock.unlockAttempt();
                            }
                        }
                    }
                }
            }

            // Top-center info panel (clock + weather)
            ColumnLayout {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 40
                spacing: 8
                // Clock
                Text {
                    id: timeText
                    text: Qt.formatDateTime(new Date(), "HH:mm")
                    font.pixelSize: 48
                    font.bold: true
                    color: Theme.textPrimary
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    id: dateText
                    text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
                    font.pixelSize: 16
                    color: Theme.textSecondary
                    opacity: 0.8
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                // Weather info (centered, no city)
                RowLayout {
                    spacing: 6
                    Layout.alignment: Qt.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: weatherData && weatherData.current_weather
                    Text {
                        text: weatherData && weatherData.current_weather ? materialSymbolForCode(weatherData.current_weather.weathercode) : "cloud"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 28
                        color: Theme.accentPrimary
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        text: weatherData && weatherData.current_weather ? (Settings.useFahrenheit ? `${Math.round(weatherData.current_weather.temperature * 9 / 5 + 32)}°F` : `${Math.round(weatherData.current_weather.temperature)}°C`) : (Settings.useFahrenheit ? "--°F" : "--°C")
                        font.pixelSize: 18
                        color: Theme.textSecondary
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                // Weather error
                Text {
                    text: weatherError
                    color: Theme.error
                    visible: weatherError !== ""
                    font.pixelSize: 10
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            // Update clock every second
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeText.text = Qt.formatDateTime(new Date(), "HH:mm");
                    dateText.text = Qt.formatDateTime(new Date(), "dddd, MMMM d");
                }
            }

            // Update weather every 10 minutes
            Timer {
                interval: 600000 // 10 minutes
                running: true
                repeat: true
                onTriggered: {
                    fetchWeatherData();
                }
            }

            // System control buttons (bottom right)
            ColumnLayout {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 32
                spacing: 12
                // Shutdown
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: shutdownArea.containsMouse ? Theme.error : "transparent"
                    border.color: Theme.error
                    border.width: 1
                    MouseArea {
                        id: shutdownArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Qt.createQmlObject('import Quickshell.Io; Process { command: ["shutdown", "-h", "now"]; running: true }', lock);
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "power_settings_new"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 24
                        color: shutdownArea.containsMouse ? Theme.onAccent : Theme.error
                    }
                }
                // Reboot
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: rebootArea.containsMouse ? Theme.accentPrimary : "transparent"
                    border.color: Theme.accentPrimary
                    border.width: 1
                    MouseArea {
                        id: rebootArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Qt.createQmlObject('import Quickshell.Io; Process { command: ["reboot"]; running: true }', lock);
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "refresh"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 24
                        color: rebootArea.containsMouse ? Theme.onAccent : Theme.accentPrimary
                    }
                }
                // Logout
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: logoutArea.containsMouse ? Theme.accentSecondary : "transparent"
                    border.color: Theme.accentSecondary
                    border.width: 1
                    MouseArea {
                        id: logoutArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Qt.createQmlObject('import Quickshell.Io; Process { command: ["loginctl", "terminate-user", "' + Quickshell.env("USER") + '"]; running: true }', lock);
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "exit_to_app"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 24
                        color: logoutArea.containsMouse ? Theme.onAccent : Theme.accentSecondary
                    }
                }
            }
        }
    }
}
