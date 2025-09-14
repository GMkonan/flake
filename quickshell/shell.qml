import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.Notifications
import QtQuick
import QtCore
import qs.Bar
import qs.Bar.Modules
import qs.Widgets
import qs.Settings
import qs.Helpers

Scope {
    id: root

    property alias appLauncherPanel: appLauncherPanel

    Component.onCompleted: {
        Quickshell.shell = root;
    }

    Bar {
        id: bar
        shell: root
    }

    Applauncher {
        id: appLauncherPanel
        visible: false
    }

    NotificationServer {
        id: notificationServer
        onNotification: function (notification) {
            notification.tracked = true;
            notificationPopup.addNotification(notification);
        }
    }

    NotificationPopup {
        id: notificationPopup
        barVisible: bar.visible
    }

    LockScreen {
        id: lockScreen
    }

    property var defaultAudioSink: Pipewire.defaultAudioSink
    property int volume: defaultAudioSink && defaultAudioSink.audio ? Math.round(defaultAudioSink.audio.volume * 100) : 0

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    IPCHandlers {
        appLauncherPanel: appLauncherPanel
        lockScreen: lockScreen
    }
}
