import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Settings

Item {
    id: wifiDisplay
    width: 22
    height: 22

    property color hoverColor: Theme.rippleEffect
    property real hoverOpacity: 0.0
    property bool isActive: mouseArea.containsMouse || (wifiPanel && wifiPanel.visible)
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: {
            if (wifiPanel.visible) {
                wifiPanel.hidePopup();
            } else {
                wifiPanel.showAt(this, 0, parent.height);
            }
        }
        onEntered: wifiDisplay.hoverOpacity = 0.18
        onExited: wifiDisplay.hoverOpacity = 0.0
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -4
        color: hoverColor
        opacity: isActive ? 0.18 : hoverOpacity
        radius: height / 2
        z: 0
        visible: opacity > 0.01
    }

    Text {
        anchors.centerIn: parent
        text: "wifi"
        font.family: isActive ? "Material Symbols Rounded" : "Material Symbols Outlined"
        font.pixelSize: 18
        color: wifiPanel.visible ? Theme.accentPrimary : Theme.textPrimary
        z: 1
    }

    PanelWindow {
        id: wifiPanel
        implicitWidth: 350
        implicitHeight: 400
        color: "transparent"
        visible: false
        property var anchorItem: null
        property real anchorX
        property real anchorY
        property var networks: [] // { ssid, signal, security, connected }
        property string connectingSsid: ""
        property string errorMsg: ""
        property string passwordPromptSsid: ""
        property string passwordInput: ""
        property bool showPasswordPrompt: false

        WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

        function showAt(item, x, y) {
            if (!item) {
                console.warn("Wifi: anchorItem is undefined, not showing panel.");
                return;
            }
            anchorItem = item;
            anchorX = x;
            anchorY = y;
            visible = true;
            refreshNetworks();
            Qt.callLater(() => {
                wifiPanel.x = anchorX - (wifiPanel.width / 2) + (anchorItem ? anchorItem.width / 2 : 0);
                wifiPanel.y = anchorY + 8;
            });
        }
        function hidePopup() {
            visible = false;
            showPasswordPrompt = false;
            errorMsg = "";
        }

        // Scan for networks
        Process {
            id: scanProcess
            running: false
            command: ["nmcli", "-t", "-f", "SSID,SECURITY,SIGNAL,IN-USE", "device", "wifi", "list"]
            stdout: StdioCollector {
                onStreamFinished: {
                    var lines = text.split("\n");
                    var nets = [];
                    var seen = {};
                    for (var i = 0; i < lines.length; ++i) {
                        var line = lines[i].trim();
                        if (!line)
                            continue;
                        var parts = line.split(":");
                        var ssid = parts[0];
                        var security = parts[1];
                        var signal = parseInt(parts[2]);
                        var inUse = parts[3] === "*";
                        if (ssid && !seen[ssid]) {
                            nets.push({
                                ssid: ssid,
                                security: security,
                                signal: signal,
                                connected: inUse
                            });
                            seen[ssid] = true;
                        }
                    }
                    wifiPanel.networks = nets;
                }
            }
        }
        function refreshNetworks() {
            scanProcess.running = true;
        }

        // Connect to a network
        Process {
            id: connectProcess
            property string ssid: ""
            property string password: ""
            running: false
            command: password ? ["nmcli", "device", "wifi", "connect", ssid, "password", password] : ["nmcli", "device", "wifi", "connect", ssid]
            stdout: StdioCollector {
                onStreamFinished: {
                    wifiPanel.connectingSsid = "";
                    wifiPanel.showPasswordPrompt = false;
                    wifiPanel.errorMsg = "";
                    refreshNetworks();
                }
            }
            stderr: StdioCollector {
                onStreamFinished: {
                    wifiPanel.connectingSsid = "";
                    wifiPanel.errorMsg = text;
                    wifiPanel.showPasswordPrompt = false;
                }
            }
        }
        function connectNetwork(ssid, security) {
            if (security && security !== "--") {
                // Prompt for password
                passwordPromptSsid = ssid;
                passwordInput = "";
                showPasswordPrompt = true;
            } else {
                connectingSsid = ssid;
                connectProcess.ssid = ssid;
                connectProcess.password = "";
                connectProcess.running = true;
            }
        }
        function submitPassword() {
            connectingSsid = passwordPromptSsid;
            connectProcess.ssid = passwordPromptSsid;
            connectProcess.password = passwordInput;
            connectProcess.running = true;
        }
        // Disconnect
        Process {
            id: disconnectProcess
            property string ssid: ""
            running: false
            command: ["nmcli", "connection", "down", "id", ssid]
            onRunningChanged: {
                if (!running) {
                    refreshNetworks();
                }
            }
        }
        function disconnectNetwork(ssid) {
            disconnectProcess.ssid = ssid;
            disconnectProcess.running = true;
        }

        // UI
        Rectangle {
            id: bg
            anchors.fill: parent
            radius: 12
            border.width: 1
            border.color: Theme.surfaceVariant
            color: Theme.backgroundPrimary
            z: 0
        }
        // Header
        Rectangle {
            id: header
            width: parent.width
            height: 56
            color: "transparent"
            Text {
                text: "Wi-Fi"
                font.pixelSize: 18
                font.bold: true
                color: Theme.textPrimary
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 16
            }
            // Refresh button
            Rectangle {
                id: refreshBtn
                width: 36
                height: 36
                radius: 18
                color: Theme.surfaceVariant
                border.color: refreshMouseArea.containsMouse ? Theme.accentPrimary : Theme.outline
                border.width: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 12
                MouseArea {
                    id: refreshMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: wifiPanel.refreshNetworks()
                }
                Text {
                    anchors.centerIn: parent
                    text: "refresh"
                    font.family: "Material Symbols Outlined"
                    font.pixelSize: 20
                    color: Theme.accentPrimary
                }
            }
        }
        // Error message
        Text {
            visible: wifiPanel.errorMsg.length > 0
            text: wifiPanel.errorMsg
            color: Theme.error
            font.pixelSize: 12
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.topMargin: 2
        }
        // Device list container
        Rectangle {
            id: listContainer
            anchors.top: header.bottom
            anchors.topMargin: wifiPanel.showPasswordPrompt ? 68 : 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 8
            color: "transparent"
            clip: true
            ListView {
                id: networkListView
                anchors.fill: parent
                spacing: 4
                boundsBehavior: Flickable.StopAtBounds
                model: wifiPanel.networks
                delegate: Rectangle {
                    id: networkEntry
                    width: parent.width
                    height: modelData.ssid === wifiPanel.passwordPromptSsid && wifiPanel.showPasswordPrompt ? 110 : 42
                    color: "transparent"
                    radius: 8

                    Rectangle {
                        anchors.fill: parent
                        radius: 8
                        color: modelData.connected ? Qt.rgba(Theme.accentPrimary.r, Theme.accentPrimary.g, Theme.accentPrimary.b, 0.18) : ((networkMouseArea.containsMouse || (modelData.ssid === wifiPanel.passwordPromptSsid && wifiPanel.showPasswordPrompt)) ? Theme.highlight : "transparent")
                        z: 0
                    }
                    RowLayout {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0

                        height: 42
                        spacing: 12
                        // Signal icon
                        Text {
                            text: signalIcon(modelData.signal)
                            font.family: "Material Symbols Outlined"
                            font.pixelSize: 20
                            color: hovered ? Theme.backgroundPrimary : (modelData.connected ? Theme.accentPrimary : Theme.textSecondary)
                            verticalAlignment: Text.AlignVCenter
                        }
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2
                            Text {
                                text: modelData.ssid || "Unknown Network"
                                color: hovered ? Theme.backgroundPrimary : (modelData.connected ? Theme.accentPrimary : Theme.textPrimary)
                                font.pixelSize: 14
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }
                            Text {
                                text: modelData.security && modelData.security !== "--" ? modelData.security : "Open"
                                color: hovered ? Theme.backgroundPrimary : (modelData.connected ? Theme.accentPrimary : Theme.textSecondary)
                                font.pixelSize: 11
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }
                        }
                        // Status
                        Text {
                            visible: modelData.connected
                            text: "connected"
                            color: hovered ? Theme.backgroundPrimary : Theme.accentPrimary
                            font.pixelSize: 11
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    // Password prompt dropdown (only for selected network)
                    Rectangle {
                        visible: modelData.ssid === wifiPanel.passwordPromptSsid && wifiPanel.showPasswordPrompt
                        width: parent.width
                        height: 60
                        radius: 8
                        color: Theme.surfaceVariant
                        border.color: passwordField.activeFocus ? Theme.accentPrimary : Theme.outline
                        border.width: 1
                        anchors.bottom: parent.bottom
                        z: 2
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 10
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 36
                                radius: 8
                                color: Theme.surfaceVariant
                                border.color: passwordField.activeFocus ? Theme.accentPrimary : Theme.outline
                                border.width: 1
                                TextInput {
                                    id: passwordField
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    text: wifiPanel.passwordInput
                                    font.pixelSize: 13
                                    color: Theme.textPrimary
                                    verticalAlignment: TextInput.AlignVCenter
                                    clip: true
                                    focus: true
                                    selectByMouse: true
                                    activeFocusOnTab: true
                                    inputMethodHints: Qt.ImhNone
                                    echoMode: TextInput.Password
                                    onTextChanged: wifiPanel.passwordInput = text
                                    onAccepted: wifiPanel.submitPassword()
                                    MouseArea {
                                        id: passwordMouseArea
                                        anchors.fill: parent
                                        onClicked: passwordField.forceActiveFocus()
                                    }
                                }
                            }
                            Rectangle {
                                width: 80
                                height: 36
                                radius: 18
                                color: Theme.accentPrimary
                                border.color: Theme.accentPrimary
                                border.width: 0
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: wifiPanel.submitPassword()
                                    cursorShape: Qt.PointingHandCursor
                                }
                                Text {
                                    anchors.centerIn: parent
                                    text: "Connect"
                                    color: Theme.backgroundPrimary
                                    font.pixelSize: 14
                                    font.bold: true
                                }
                            }
                        }
                    }
                    MouseArea {
                        id: networkMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (modelData.connected) {
                                wifiPanel.disconnectNetwork(modelData.ssid);
                            } else if (modelData.security && modelData.security !== "--") {
                                wifiPanel.passwordPromptSsid = modelData.ssid;
                                wifiPanel.passwordInput = "";
                                wifiPanel.showPasswordPrompt = true;
                            } else {
                                wifiPanel.connectNetwork(modelData.ssid, modelData.security);
                            }
                        }
                    }
                    // Helper for hover text color
                    property bool hovered: networkMouseArea.containsMouse || (modelData.ssid === wifiPanel.passwordPromptSsid && wifiPanel.showPasswordPrompt)
                }
            }
        }
        // Scroll indicator
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.top: listContainer.top
            anchors.bottom: listContainer.bottom
            width: 4
            radius: 2
            color: Theme.textSecondary
            opacity: networkListView.contentHeight > networkListView.height ? 0.3 : 0
            visible: opacity > 0
        }
    }

    // Helper for signal icon
    function signalIcon(signal) {
        if (signal >= 80)
            return "network_wifi_4_bar";
        if (signal >= 60)
            return "network_wifi_3_bar";
        if (signal >= 40)
            return "network_wifi_2_bar";
        if (signal >= 20)
            return "network_wifi_1_bar";
        return "wifi_0_bar";
    }
}
