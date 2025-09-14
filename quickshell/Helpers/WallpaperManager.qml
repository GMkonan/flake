pragma Singleton
import QtQuick
import Quickshell.Io

Item {
    id: manager

    // Hardcoded directory for v1
    property string wallpaperDirectory: "/home/konan/flake/wallpapers"
    property var wallpaperList: []
    property string currentWallpaper: ""
    property bool scanning: false

    // Log initial state
    Component.onCompleted: {
        loadWallpapers();
    }

    // Scan directory for wallpapers
    function loadWallpapers() {
        scanning = true;
        wallpaperList = [];
        findProcess.tempList = [];
        findProcess.running = true;
    }

    function setCurrentWallpaper(path) {
        currentWallpaper = path;
    }

    Process {
        id: findProcess
        property var tempList: []
        running: false
        command: ["find", manager.wallpaperDirectory, "-type", "f", "-name", "*.png", "-o", "-name", "*.jpg", "-o", "-name", "*.jpeg"]
        onRunningChanged: {}
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = text.split("\n");
                for (var i = 0; i < lines.length; ++i) {
                    var trimmed = lines[i].trim();
                    if (trimmed) {
                        findProcess.tempList.push(trimmed);
                    }
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {}
        }
        onExited: {
            manager.wallpaperList = findProcess.tempList.slice();
            scanning = false;
        }
    }
}
