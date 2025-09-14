import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Helpers
import qs.Settings

ShellRoot {
    property string wallpaperSource: Settings.currentWallpaper !== "" ? Settings.currentWallpaper : "/home/konan/flake/wallpapers/dark/astronaut.png"
    PanelWindow {
        anchors {
            bottom: true
            top: true
            right: true
            left: true
        }
        margins {
            top: 0
        }
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "quickshell-wallpaper"
        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: wallpaperSource
            cache: true
            smooth: true
        }
    }
}
