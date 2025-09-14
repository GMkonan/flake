import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Helpers
import qs.Settings

ShellRoot {
    property string wallpaperSource: Settings.currentWallpaper !== "" ? Settings.currentWallpaper : "/home/konan/flake/wallpapers/dark/astronaut.png"
    PanelWindow {
        anchors {
            top: true
            bottom: true
            right: true
            left: true
        }
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "quickshell-overview"
        Image {
            id: bgImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: wallpaperSource
            cache: true
            smooth: true
            visible: true // Show the original for FastBlur input
        }
    }
}
