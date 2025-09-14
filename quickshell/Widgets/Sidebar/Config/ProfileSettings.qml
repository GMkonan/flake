import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import qs.Settings

Rectangle {
    id: profileSettingsCard
    Layout.fillWidth: true
    Layout.preferredHeight: 140
    color: Theme.surface
    radius: 18
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
                color: Theme.accentPrimary
            }

            Text {
                text: "Profile Image"
                font.pixelSize: 16
                font.bold: true
                color: Theme.textPrimary
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
                color: Theme.surfaceVariant
                border.color: profileImageInput.activeFocus ? Theme.accentPrimary : Theme.outline
                border.width: 1

                Image {
                    id: avatarImage
                    anchors.fill: parent
                    anchors.margins: 2
                    source: Settings.profileImage
                    fillMode: Image.PreserveAspectCrop
                    visible: true
                    asynchronous: true
                    cache: false
                    sourceSize.width: 64
                    sourceSize.height: 64
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
                    font.pixelSize: 18
                    color: Theme.accentPrimary
                    visible: Settings.profileImage === ""
                }
            }

            // Text input styled exactly like weather city
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 8
                color: Theme.surfaceVariant
                border.color: profileImageInput.activeFocus ? Theme.accentPrimary : Theme.outline
                border.width: 1

                TextInput {
                    id: profileImageInput
                    anchors.fill: parent
                    anchors.margins: 12
                    text: Settings.profileImage
                    font.pixelSize: 13
                    color: Theme.textPrimary
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    focus: true
                    selectByMouse: true
                    activeFocusOnTab: true
                    inputMethodHints: Qt.ImhNone
                    onTextChanged: {
                        Settings.profileImage = text;
                        Settings.saveSettings();
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

        // Video Path Input Row
        RowLayout {
            spacing: 8
            Layout.fillWidth: true

            Text {
                text: "Video Path"
                font.pixelSize: 14
                color: Theme.textPrimary
                Layout.alignment: Qt.AlignVCenter
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                radius: 8
                color: Theme.surfaceVariant
                border.color: videoPathInput.activeFocus ? Theme.accentPrimary : Theme.outline
                border.width: 1

                TextInput {
                    id: videoPathInput
                    anchors.fill: parent
                    anchors.margins: 12
                    text: Settings.videoPath !== undefined ? Settings.videoPath : ""
                    font.pixelSize: 13
                    color: Theme.textPrimary
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    selectByMouse: true
                    activeFocusOnTab: true
                    inputMethodHints: Qt.ImhUrlCharactersOnly
                    onTextChanged: {
                        Settings.videoPath = text;
                        Settings.saveSettings();
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: videoPathInput.forceActiveFocus()
                    }
                }
            }
        }
    }
}
