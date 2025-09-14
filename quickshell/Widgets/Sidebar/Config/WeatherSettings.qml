import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import qs.Settings

Rectangle {
    id: weatherSettingsCard
    Layout.fillWidth: true
    Layout.preferredHeight: 180
    color: Theme.surface
    radius: 18

    // Properties for binding
    property string weatherCity: ""
    property bool useFahrenheit: false

    signal cityChanged(string city)
    signal temperatureUnitChanged(bool useFahrenheit)

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
                color: Theme.accentPrimary
            }

            Text {
                text: "Weather Settings"
                font.pixelSize: 16
                font.bold: true
                color: Theme.textPrimary
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
                color: Theme.textPrimary
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 8
                color: Theme.surfaceVariant
                border.color: cityInput.activeFocus ? Theme.accentPrimary : Theme.outline
                border.width: 1

                TextInput {
                    id: cityInput
                    anchors.fill: parent
                    anchors.margins: 12
                    text: weatherCity
                    font.pixelSize: 13
                    color: Theme.textPrimary
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    focus: true
                    selectByMouse: true
                    activeFocusOnTab: true
                    inputMethodHints: Qt.ImhNone

                    onTextChanged: {
                        cityChanged(text);
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
                color: Theme.textPrimary
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
                color: Theme.accentPrimary
                border.color: Theme.accentPrimary
                border.width: 2

                Rectangle {
                    id: thumb
                    width: 28
                    height: 28
                    radius: 14
                    color: Theme.surface
                    border.color: Theme.outline
                    border.width: 1
                    y: 2
                    x: useFahrenheit ? customSwitch.width - width - 2 : 2

                    Text {
                        anchors.centerIn: parent
                        text: useFahrenheit ? "°F" : "°C"
                        font.pixelSize: 12
                        font.bold: true
                        color: Theme.textPrimary
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
                        temperatureUnitChanged(!useFahrenheit);
                    }
                }
            }
        }
    }
}
