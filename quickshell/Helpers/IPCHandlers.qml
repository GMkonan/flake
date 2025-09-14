import Quickshell.Io

IpcHandler {
    property var appLauncherPanel
    property var lockScreen

    target: "globalIPC"

    // Toggle Applauncher visibility
    function toggleLauncher(): void {
        if (!appLauncherPanel) {
            console.warn("AppLauncherIpcHandler: appLauncherPanel not set!");
            return;
        }
        if (appLauncherPanel.visible) {
            appLauncherPanel.hidePanel();
        } else {
            console.log("[IPC] Applauncher show() called");
            appLauncherPanel.showAt();
        }
    }

    function toggleLock(): void {
        if (!lockScreen) {
            console.warn("LockScreenIpcHandler: lockScreen not set!");

            return;
        }

        console.log("[IPC] LockScreen lock() called");

        lockScreen.locked = true;
    }
}
