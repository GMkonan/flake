import QtQuick
import Quickshell.Io
import qs.Settings
import qs.Components

Item {
    id: batteryDisplay
    property string battery: ""
    property bool hasBattery: false
    visible: hasBattery

    // The total width will match the pill's width when shown, or just icon when hidden
    width: pillIndicator.width
    height: pillIndicator.height

    PillIndicator {
        id: pillIndicator
        icon: getBatteryIcon()
        text: getBatteryPercentage()

        pillColor: Theme.surfaceVariant
        iconCircleColor: getIconColor()
        iconTextColor: Theme.backgroundPrimary
        textColor: Theme.textPrimary
        showPill: true
    }

    Process {
        id: batteryCheck
        command: ["sh", "-c", "test -d /sys/class/power_supply/BAT*"]
        running: true
        onExited: function (exitCode) {
            hasBattery = exitCode === 0;
        }
    }

    Process {
        id: batteryProc
        command: ["sh", "-c", "echo $(cat /sys/class/power_supply/BAT*/capacity),$(cat /sys/class/power_supply/BAT*/status)"]
        running: hasBattery

        stdout: SplitParser {
            onRead: function (data) {
                const [capacityStr, status] = data.trim().split(',');
                const capacity = parseInt(capacityStr);
                battery = `${capacity},${status}`;
            }
        }
    }

    Timer {
        interval: 10000  // Update every 10 seconds instead of 1 second
        running: hasBattery
        repeat: true
        onTriggered: batteryProc.running = true
    }

    function getBatteryIcon() {
        if (!battery)
            return "battery_unknown";

        const [capacityStr, status] = battery.split(',');
        const capacity = parseInt(capacityStr);

        if (status === "Charging")
            return "battery_charging_full";

        if (capacity <= 20)
            return "battery_0_bar";
        else if (capacity <= 40)
            return "battery_2_bar";
        else if (capacity <= 60)
            return "battery_4_bar";
        else if (capacity <= 80)
            return "battery_5_bar";
        else
            return "battery_full";
    }

    function getBatteryPercentage() {
        if (!battery)
            return "0%";
        return battery.split(',')[0] + "%";
    }

    function getIconColor() {
        if (!battery)
            return Theme.accentPrimary;

        const capacity = parseInt(battery.split(',')[0]);
        return capacity <= 20 ? Theme.error : Theme.accentPrimary;
    }

    Component.onCompleted: {
        if (hasBattery) {
            batteryProc.running = true;
        }
    }
}
