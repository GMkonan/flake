pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: processesRoot
    property string userName: "User"
    property string uptimeText: "--:--"
    property int uptimeUpdateTrigger: 0

    property Process whoamiProcess: Process {
        command: ["whoami"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                processesRoot.userName = this.text.trim();
                whoamiProcess.running = false;
            }
        }
    }

    property Process shutdownProcess: Process {
        command: ["shutdown", "-h", "now"]
        running: false
    }
    property Process rebootProcess: Process {
        command: ["reboot"]
        running: false
    }
    property Process logoutProcess: Process {
        command: ["niri", "msg", "action", "quit", "--skip-confirmation"]
        running: false
    }

    property Process uptimeProcess: Process {
        command: ["sh", "-c", "uptime | awk -F 'up ' '{print $2}' | awk -F ',' '{print $1}' | xargs"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                processesRoot.uptimeText = this.text.trim();
                uptimeProcess.running = false;
            }
        }
    }

    Component.onCompleted: {
        whoamiProcess.running = true;
        updateUptime();
    }

    function shutdown() {
        shutdownProcess.running = true;
    }
    function reboot() {
        rebootProcess.running = true;
    }
    function logout() {
        logoutProcess.running = true;
    }

    function updateUptime() {
        uptimeProcess.running = true;
    }

    onUptimeUpdateTriggerChanged: {
        uptimeProcess.running = true;
    }
}
