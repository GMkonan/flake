import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Quickshell.Io
import "root:/Settings" as Settings
import "root:/Components" as Components

Rectangle {
    id: systemMonitor
    width: 70
    height: 200
    color: "transparent"

    property real cpuUsage: 0
    property real memoryUsage: 0
    property real diskUsage: 0
    property bool isVisible: false

    // Timers to control when processes run
    Timer {
        id: cpuTimer
        interval: 2000
        repeat: true
        running: isVisible
        onTriggered: cpuInfo.running = true
    }

    Timer {
        id: memoryTimer
        interval: 3000
        repeat: true
        running: isVisible
        onTriggered: memoryInfo.running = true
    }

    Timer {
        id: diskTimer
        interval: 5000
        repeat: true
        running: isVisible
        onTriggered: diskInfo.running = true
    }

    // Process for getting CPU usage
    Process {
        id: cpuInfo
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | awk -F'%' '{print $1}'"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                let usage = parseFloat(data.trim());
                if (!isNaN(usage)) {
                    systemMonitor.cpuUsage = usage;
                }
                cpuInfo.running = false;
            }
        }
    }

    // Process for getting memory usage
    Process {
        id: memoryInfo
        command: ["sh", "-c", "free | grep Mem | awk '{print int($3/$2 * 100)}'"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                let usage = parseFloat(data.trim());
                if (!isNaN(usage)) {
                    systemMonitor.memoryUsage = usage;
                }
                memoryInfo.running = false;
            }
        }
    }

    // Process for getting disk usage
    Process {
        id: diskInfo
        command: ["sh", "-c", "df / | tail -1 | awk '{print int($5)}'"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                let usage = parseFloat(data.trim());
                if (!isNaN(usage)) {
                    systemMonitor.diskUsage = usage;
                }
                diskInfo.running = false;
            }
        }
    }

    // Function to start monitoring
    function startMonitoring() {
        isVisible = true;
        // Trigger initial readings
        cpuInfo.running = true;
        memoryInfo.running = true;
        diskInfo.running = true;
    }

    // Function to stop monitoring
    function stopMonitoring() {
        isVisible = false;
        cpuInfo.running = false;
        memoryInfo.running = false;
        diskInfo.running = false;
    }

    Rectangle {
        id: card
        anchors.fill: parent
        color: Settings.Theme.surface
        radius: 18

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 12
            Layout.alignment: Qt.AlignVCenter

            // CPU Usage
            Components.CircularProgressBar {
                progress: cpuUsage / 100
                size: 50
                strokeWidth: 4
                hasNotch: true
                notchIcon: "speed"
                notchIconSize: 14
                Layout.alignment: Qt.AlignHCenter
            }

            // Memory Usage
            Components.CircularProgressBar {
                progress: memoryUsage / 100
                size: 50
                strokeWidth: 4
                hasNotch: true
                notchIcon: "memory"
                notchIconSize: 14
                Layout.alignment: Qt.AlignHCenter
            }

            // Disk Usage
            Components.CircularProgressBar {
                progress: diskUsage / 100
                size: 50
                strokeWidth: 4
                hasNotch: true
                notchIcon: "storage"
                notchIconSize: 14
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
