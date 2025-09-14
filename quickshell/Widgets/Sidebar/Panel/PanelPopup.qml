import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Settings
import qs.Widgets.Sidebar.Config
import qs.Components

PanelWindow {
    id: panelPopup
    implicitWidth: 500
    implicitHeight: 750
    visible: false
    color: "transparent"
    screen: modelData
    anchors.top: true
    anchors.right: true
    margins.top: -24
    WlrLayershell.keyboardFocus: (settingsModal.visible && mouseArea.containsMouse) ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    // Animation properties
    property real slideOffset: width
    property bool isAnimating: false

    function showAt() {
        if (!visible) {
            visible = true;
            forceActiveFocus();
            slideAnim.from = width;
            slideAnim.to = 0;
            slideAnim.running = true;

            // Start system monitoring when sidebar becomes visible
            if (systemMonitor)
                systemMonitor.startMonitoring();
            if (weather)
                weather.startWeatherFetch();
            if (systemWidget)
                systemWidget.panelVisible = true;
            if (quickAccessWidget)
                quickAccessWidget.panelVisible = true;
        }
    }

    function hidePopup() {
        if (visible) {
            slideAnim.from = 0;
            slideAnim.to = width;
            slideAnim.running = true;
        }
    }

    NumberAnimation {
        id: slideAnim
        target: panelPopup
        property: "slideOffset"
        duration: 300
        easing.type: Easing.OutCubic

        onStopped: {
            if (panelPopup.slideOffset === panelPopup.width) {
                panelPopup.visible = false;

                // Stop system monitoring when sidebar becomes hidden
                if (systemMonitor)
                    systemMonitor.stopMonitoring();
                if (weather)
                    weather.stopWeatherFetch();
                if (systemWidget)
                    systemWidget.panelVisible = false;
                if (quickAccessWidget)
                    quickAccessWidget.panelVisible = false;
            }
            panelPopup.isAnimating = false;
        }

        onStarted: {
            panelPopup.isAnimating = true;
        }
    }

    property int leftPadding: 20
    property int bottomPadding: 20

    Rectangle {
        id: mainRectangle
        width: parent.width - leftPadding
        height: parent.height - bottomPadding
        anchors.top: parent.top
        x: leftPadding + slideOffset
        y: 0
        color: Theme.backgroundPrimary
        bottomLeftRadius: 20
        z: 0

        Behavior on x {
            enabled: !panelPopup.isAnimating
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    property alias settingsModal: settingsModal
    SettingsModal {
        id: settingsModal
    }

    Item {
        anchors.fill: mainRectangle
        x: slideOffset

        Behavior on x {
            enabled: !panelPopup.isAnimating
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 16

            System {
                id: systemWidget
                Layout.alignment: Qt.AlignHCenter
                z: 3
            }

            Weather {
                id: weather
                Layout.alignment: Qt.AlignHCenter
                z: 2
            }

            // Music and System Monitor row
            RowLayout {
                spacing: 12
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                Music {
                    z: 2
                }

                SystemMonitor {
                    id: systemMonitor
                    z: 2
                }
            }

            // Power profile, Wifi and Bluetooth row
            RowLayout {
                Layout.alignment: Qt.AlignLeft
                Layout.preferredHeight: 80
                spacing: 16
                z: 3

                PowerProfile {
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredHeight: 80
                }

                // Network card containing Wifi and Bluetooth
                Rectangle {
                    Layout.preferredHeight: 70
                    Layout.preferredWidth: 140
                    Layout.fillWidth: false
                    color: Theme.surface
                    radius: 18

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 20

                        // Wifi button
                        Rectangle {
                            id: wifiButton
                            width: 36
                            height: 36
                            radius: 18
                            border.color: Theme.accentPrimary
                            border.width: 1
                            color: wifiButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: "wifi"
                                font.family: "Material Symbols Outlined"
                                font.pixelSize: 22
                                color: wifiButtonArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }

                            MouseArea {
                                id: wifiButtonArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: wifiPanelModal.showAt()
                            }
                        }

                        // Bluetooth button
                        Rectangle {
                            id: bluetoothButton
                            width: 36
                            height: 36
                            radius: 18
                            border.color: Theme.accentPrimary
                            border.width: 1
                            color: bluetoothButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: "bluetooth"
                                font.family: "Material Symbols Outlined"
                                font.pixelSize: 22
                                color: bluetoothButtonArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }

                            MouseArea {
                                id: bluetoothButtonArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: bluetoothPanelModal.showAt()
                            }
                        }
                    }
                }
            }

            // Hidden panel components for modal functionality
            WifiPanel {
                id: wifiPanelModal
                visible: false
            }
            BluetoothPanel {
                id: bluetoothPanelModal
                visible: false
            }

            Item {
                Layout.fillHeight: true
            }

            // QuickAccess widget
            QuickAccess {
                id: quickAccessWidget
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: -16
                z: 2
                isRecording: panelPopup.isRecording

                onRecordingRequested: {
                    startRecording();
                }

                onStopRecordingRequested: {
                    stopRecording();
                }

                onRecordingStateMismatch: function (actualState) {
                    isRecording = actualState;
                    quickAccessWidget.isRecording = actualState;
                }

                onSettingsRequested: {
                    settingsModal.visible = true;
                }
                onWallpaperRequested: {
                    wallpaperPanelModal.visible = true;
                }
            }
        }
        Keys.onEscapePressed: panelPopup.hidePopup()
    }

    onVisibleChanged: if (!visible) /* cleanup if needed */{}

    // Update height when screen changes
    onScreenChanged: {
        if (screen)
        // Height is now hardcoded to 720, no need to update
        {}
    }

    // Recording properties
    property bool isRecording: false
    property var recordingProcess: null
    property var recordingPid: null

    // Start screen recording
    function startRecording() {
        var currentDate = new Date();
        var hours = String(currentDate.getHours()).padStart(2, '0');
        var minutes = String(currentDate.getMinutes()).padStart(2, '0');
        var day = String(currentDate.getDate()).padStart(2, '0');
        var month = String(currentDate.getMonth() + 1).padStart(2, '0');
        var year = currentDate.getFullYear();

        var filename = hours + "-" + minutes + "-" + day + "-" + month + "-" + year + ".mp4";
        var outputPath = Settings.videoPath + filename;
        var command = "gpu-screen-recorder -w portal -f 60 -a default_output -o " + outputPath;
        var qmlString = 'import Quickshell.Io; Process { command: ["sh", "-c", "' + command + '"]; running: true }';

        recordingProcess = Qt.createQmlObject(qmlString, panelPopup);
        isRecording = true;
        quickAccessWidget.isRecording = true;
    }

    // Stop recording with cleanup
    function stopRecording() {
        if (recordingProcess && isRecording) {
            var stopQmlString = 'import Quickshell.Io; Process { command: ["sh", "-c", "pkill -SIGINT -f \'gpu-screen-recorder.*portal\'"]; running: true; onExited: function() { destroy() } }';

            var stopProcess = Qt.createQmlObject(stopQmlString, panelPopup);

            var cleanupTimer = Qt.createQmlObject('import QtQuick; Timer { interval: 3000; running: true; repeat: false }', panelPopup);
            cleanupTimer.triggered.connect(function () {
                if (recordingProcess) {
                    recordingProcess.running = false;
                    recordingProcess.destroy();
                    recordingProcess = null;
                }

                var forceKillQml = 'import Quickshell.Io; Process { command: ["sh", "-c", "pkill -9 -f \'gpu-screen-recorder.*portal\' 2>/dev/null || true"]; running: true; onExited: function() { destroy() } }';
                var forceKillProcess = Qt.createQmlObject(forceKillQml, panelPopup);

                cleanupTimer.destroy();
            });
        }

        isRecording = false;
        quickAccessWidget.isRecording = false;
        recordingPid = null;
    }

    // Clean up processes on destruction
    Component.onDestruction: {
        if (isRecording) {
            stopRecording();
        }
        if (recordingProcess) {
            recordingProcess.running = false;
            recordingProcess.destroy();
            recordingProcess = null;
        }
    }

    Corners {
        id: sidebarCornerLeft
        position: "bottomright"
        size: 1.1
        fillColor: Theme.backgroundPrimary
        anchors.top: mainRectangle.top
        offsetX: -447 + panelPopup.slideOffset
        offsetY: 0

        Behavior on offsetX {
            enabled: !panelPopup.isAnimating
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    Corners {
        id: sidebarCornerBottom
        position: "bottomright"
        size: 1.1
        fillColor: Theme.backgroundPrimary
        offsetX: 33 + panelPopup.slideOffset
        offsetY: 46

        Behavior on offsetX {
            enabled: !panelPopup.isAnimating
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    WallpaperPanel {
        id: wallpaperPanelModal
        visible: false
        Component.onCompleted: {
            if (parent) {
                wallpaperPanelModal.anchors.top = parent.top;
                wallpaperPanelModal.anchors.right = parent.right;
            }
        }
        // Add a close button inside WallpaperPanel.qml for user to close the modal
    }
}
