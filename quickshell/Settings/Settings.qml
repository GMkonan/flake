pragma Singleton
import QtQuick
import QtCore

QtObject {
    property string weatherCity: "Vitoria"
    property string profileImage: "https://pbs.twimg.com/profile_images/1890810779030458369/6uMpBkV5_400x400.jpg"
    property bool useFahrenheit
    property string wallpaperFolder: "/home/konan/flake/wallpapers/dark" // Default path, make persistent
    property string currentWallpaper: ""
    property string videoPath: "~/Videos/" // Default path, make persistent

    // Settings persistence
    property var settings: Qt.createQmlObject('import QtCore; Settings { category: "Quickshell" }', this, "settings")

    Component.onCompleted: {
        loadSettings();
    }

    function loadSettings() {
        let wc = settings.value("weatherCity", "Vitoria");
        weatherCity = (wc !== undefined && wc !== null) ? wc : "Dinslaken";
        let pi = settings.value("profileImage", "https://pbs.twimg.com/profile_images/1890810779030458369/6uMpBkV5_400x400.jpg");
        profileImage = (pi !== undefined && pi !== null) ? pi : "https://pbs.twimg.com/profile_images/1890810779030458369/6uMpBkV5_400x400.jpg";
        let tempUnit = settings.value("weatherTempUnit", "celsius");
        useFahrenheit = (tempUnit === "fahrenheit");
        wallpaperFolder = settings.value("wallpaperFolder", "/home/konan/flake/wallpapers/dark");
        currentWallpaper = settings.value("currentWallpaper", "");
        videoPath = settings.value("videoPath", "/home/konan/Videos");
        console.log("Loaded profileImage:", profileImage);
    }

    function saveSettings() {
        settings.setValue("weatherCity", weatherCity);
        settings.setValue("profileImage", profileImage);
        settings.setValue("weatherTempUnit", useFahrenheit ? "fahrenheit" : "celsius");
        settings.setValue("wallpaperFolder", wallpaperFolder);
        settings.setValue("currentWallpaper", currentWallpaper);
        settings.setValue("videoPath", videoPath);
        settings.sync();
        console.log("Saving profileImage:", profileImage);
    }

    // Property change handlers to auto-save (all commented out for explicit save only)
    // onWeatherCityChanged: saveSettings()
    // onProfileImageChanged: saveSettings()
    // onUseFahrenheitChanged: saveSettings()
}
