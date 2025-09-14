import QtQuick
import Quickshell.Io
import qs.Settings
import qs.Components

Item {
    id: brightnessDisplay
    property int brightness: -1

    width: pill.width
    height: pill.height

    FileView {
        id: brightnessFile
        path: "/tmp/brightness_osd_level"
        watchChanges: true
        blockLoading: true

        onLoaded: updateBrightness()
        onFileChanged: {
            brightnessFile.reload();
            updateBrightness();
        }

        function updateBrightness() {
            const val = parseInt(brightnessFile.text());
            if (!isNaN(val) && val !== brightnessDisplay.brightness) {
                brightnessDisplay.brightness = val;
                pill.text = brightness + "%";
                pill.show();
            }
        }
    }

    PillIndicator {
        id: pill
        icon: "brightness_high"
        text: brightness >= 0 ? brightness + "%" : ""
        pillColor: Theme.surfaceVariant
        iconCircleColor: Theme.accentPrimary
        iconTextColor: Theme.backgroundPrimary
        textColor: Theme.textPrimary
    }

    Component.onCompleted: {
        if (brightness >= 0) {
            pill.show();
        }
    }
}
