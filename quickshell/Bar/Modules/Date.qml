pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string date: {
        Qt.formatDateTime(clock.date, "ddd, dd MMM");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}