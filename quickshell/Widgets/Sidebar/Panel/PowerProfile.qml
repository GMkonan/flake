import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Quickshell.Services.UPower
import qs.Settings

Rectangle {
    id: card
    width: 200
    height: 70
    color: Theme.surface
    radius: 18

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        // Performance
        Rectangle {
            width: 36
            height: 36
            radius: 18
            border.color: Theme.accentPrimary
            border.width: 1
            color: (typeof PowerProfiles !== 'undefined' && PowerProfiles.profile === PowerProfile.Performance) ? Theme.accentPrimary : (perfMouseArea.containsMouse ? Theme.accentPrimary : "transparent")
            opacity: (typeof PowerProfiles !== 'undefined' && !PowerProfiles.hasPerformanceProfile) ? 0.4 : 1

            Text {
                anchors.centerIn: parent
                text: "speed"
                font.family: "Material Symbols Outlined"
                font.pixelSize: 22
                color: (typeof PowerProfiles !== 'undefined' && PowerProfiles.profile === PowerProfile.Performance) || perfMouseArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: perfMouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: typeof PowerProfiles !== 'undefined' && PowerProfiles.hasPerformanceProfile
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (typeof PowerProfiles !== 'undefined')
                        PowerProfiles.profile = PowerProfile.Performance;
                }
            }
        }

        // Balanced
        Rectangle {
            width: 36
            height: 36
            radius: 18
            border.color: Theme.accentPrimary
            border.width: 1
            color: (typeof PowerProfiles !== 'undefined' && PowerProfiles.profile === PowerProfile.Balanced) ? Theme.accentPrimary : (balMouseArea.containsMouse ? Theme.accentPrimary : "transparent")
            opacity: 1

            Text {
                anchors.centerIn: parent
                text: "balance"
                font.family: "Material Symbols Outlined"
                font.pixelSize: 22
                color: (typeof PowerProfiles !== 'undefined' && PowerProfiles.profile === PowerProfile.Balanced) || balMouseArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: balMouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (typeof PowerProfiles !== 'undefined')
                        PowerProfiles.profile = PowerProfile.Balanced;
                }
            }
        }

        // Power Saver
        Rectangle {
            width: 36
            height: 36
            radius: 18
            border.color: Theme.accentPrimary
            border.width: 1
            color: (typeof PowerProfiles !== 'undefined' && PowerProfiles.profile === PowerProfile.PowerSaver) ? Theme.accentPrimary : (saveMouseArea.containsMouse ? Theme.accentPrimary : "transparent")
            opacity: 1

            Text {
                anchors.centerIn: parent
                text: "eco"
                font.family: "Material Symbols Outlined"
                font.pixelSize: 22
                color: (typeof PowerProfiles !== 'undefined' && PowerProfiles.profile === PowerProfile.PowerSaver) || saveMouseArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: saveMouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (typeof PowerProfiles !== 'undefined')
                        PowerProfiles.profile = PowerProfile.PowerSaver;
                }
            }
        }
    }
}
