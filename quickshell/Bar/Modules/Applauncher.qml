import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Settings
import Quickshell.Wayland
import "../../Helpers/Fuzzysort.js" as Fuzzysort

PanelWindow {
    id: appLauncherPanel
    implicitWidth: 660
    implicitHeight: 640
    color: "transparent"
    visible: false
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    screen: (typeof modelData !== 'undefined' ? modelData : null)
    property bool shouldBeVisible: false

    anchors.top: true
    anchors.right: true
    margins.top: -26
    //

    // anchors.top: true
    // anchors.right: true
    // anchors.: true
    // margins.top: -26

    function showAt() {
        visible = true;
        shouldBeVisible = true;
        searchField.forceActiveFocus();
    }

    function hidePanel() {
        shouldBeVisible = false;
    }

    Rectangle {
        id: root
        width: 400
        height: 640
        x: (parent.width - width) / 2 // Horizontally centered
        color: Theme.backgroundPrimary
        bottomLeftRadius: 28
        bottomRightRadius: 28

        property var appModel: DesktopEntries.applications.values
        property var filteredApps: []
        property int selectedIndex: 0
        property int targetY: (parent.height - height) / 2 // Centered vertically
        y: appLauncherPanel.shouldBeVisible ? targetY : -height // Slide from above
        Behavior on y {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        scale: appLauncherPanel.shouldBeVisible ? 1 : 0
        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutCubic
            }
        }
        onScaleChanged: {
            if (scale === 0 && !appLauncherPanel.shouldBeVisible) {
                appLauncherPanel.visible = false;
            }
        }
        function isMathExpression(str) {
            // Allow numbers, operators, parentheses, decimal points, spaces
            return /^[-+*/().0-9\s]+$/.test(str);
        }
        function safeEval(expr) {
            // Only allow safe math expressions
            try {
                // eslint-disable-next-line no-eval
                return Function('return (' + expr + ')')();
            } catch (e) {
                return undefined;
            }
        }
        function updateFilter() {
            var query = searchField.text ? searchField.text.toLowerCase() : "";
            var apps = root.appModel;
            var results = [];
            // Calculator mode: starts with '='
            if (query.startsWith("=")) {
                var expr = searchField.text.slice(1).trim();
                if (expr && isMathExpression(expr)) {
                    var value = safeEval(expr);
                    if (value !== undefined && value !== null && value !== "") {
                        results.push({
                            isCalculator: true,
                            name: `Calculator: ${expr} = ${value}`,
                            result: value,
                            expr: expr,
                            icon: "calculate"
                        });
                    }
                }
            }
            // Normal app search
            if (!query || query.startsWith("=")) {
                results = results.concat(apps);
            } else {
                var fuzzyResults = Fuzzysort.go(query, apps, {
                    keys: ["name", "comment", "genericName"]
                });
                results = results.concat(fuzzyResults.map(function (r) {
                    return r.obj;
                }));
            }
            root.filteredApps = results;
            root.selectedIndex = 0; // reset selection
        }
        function selectNext() {
            if (filteredApps.length > 0)
                selectedIndex = Math.min(selectedIndex + 1, filteredApps.length - 1);
        }
        function selectPrev() {
            if (filteredApps.length > 0)
                selectedIndex = Math.max(selectedIndex - 1, 0);
        }
        function activateSelected() {
            if (filteredApps.length === 0)
                return;
            var modelData = filteredApps[selectedIndex];
            if (modelData.isCalculator) {
                Qt.callLater(function () {
                    Quickshell.clipboardText = String(modelData.result);
                    Quickshell.execDetached(["notify-send", "Calculator Result", `${modelData.expr} = ${modelData.result} (copied to clipboard)`]);
                });
            } else if (modelData.execString) {
                Quickshell.execDetached(["sh", "-c", modelData.execString]);
            } else if (modelData.exec) {
                Quickshell.execDetached(["sh", "-c", modelData.exec]);
            } else {
                if (!modelData.isCalculator)
                    console.warn("Cannot launch app:", modelData.name, "missing execString or exec", modelData);
            }
            appLauncherPanel.hidePanel();
        }
        Component.onCompleted: updateFilter()
        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 32
            spacing: 18

            Rectangle {
                Layout.fillWidth: true
                height: 1.5
                color: Theme.outline
                opacity: 0.10
            }
            // Search Bar
            Rectangle {
                id: searchBar
                color: Theme.surfaceVariant
                radius: 22
                height: 48
                Layout.fillWidth: true
                //border.color: searchField.activeFocus ? Theme.accentPrimary : Theme.outline
                //border.width: searchField.activeFocus ? 2.5 : 1.5
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    anchors.margins: 14
                    Text {
                        text: "search"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 22
                        color: searchField.activeFocus ? Theme.accentPrimary : Theme.textSecondary
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField {
                        id: searchField
                        placeholderText: "Search apps..."
                        color: Theme.textPrimary
                        placeholderTextColor: Theme.textSecondary
                        background: null
                        font.pixelSize: 17
                        Layout.fillWidth: true
                        onTextChanged: root.updateFilter()
                        selectedTextColor: Theme.onAccent
                        selectionColor: Theme.accentPrimary
                        padding: 2
                        verticalAlignment: TextInput.AlignVCenter
                        leftPadding: 0
                        rightPadding: 0
                        font.bold: true

                        Keys.onDownPressed: root.selectNext()
                        Keys.onUpPressed: root.selectPrev()
                        Keys.onEnterPressed: root.activateSelected()
                        Keys.onReturnPressed: root.activateSelected()
                        Keys.onEscapePressed: appLauncherPanel.hidePanel()
                    }
                }
                Behavior on border.color {
                    ColorAnimation {
                        duration: 120
                    }
                }
                Behavior on border.width {
                    NumberAnimation {
                        duration: 120
                    }
                }
            }
            // App List Card
            Rectangle {
                color: Theme.surface
                radius: 20
                //border.color: Theme.outline
                //border.width: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                anchors.margins: 0
                property int innerPadding: 16
                // Add an Item for padding
                Item {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.innerPadding
                    visible: false // for layout only
                }
                ListView {
                    id: appList
                    anchors.fill: parent
                    anchors.margins: parent.innerPadding
                    spacing: 2
                    model: root.filteredApps
                    currentIndex: root.selectedIndex
                    delegate: Item {
                        id: appDelegate
                        width: appList.width
                        height: 48
                        property bool hovered: mouseArea.containsMouse
                        property bool isSelected: index === root.selectedIndex
                        Rectangle {
                            anchors.fill: parent
                            color: hovered || isSelected ? Theme.accentPrimary : "transparent"
                            radius: 12
                            border.color: hovered || isSelected ? Theme.accentPrimary : "transparent"
                            border.width: hovered || isSelected ? 2 : 0
                            Behavior on color {
                                ColorAnimation {
                                    duration: 120
                                }
                            }
                            Behavior on border.color {
                                ColorAnimation {
                                    duration: 120
                                }
                            }
                            Behavior on border.width {
                                NumberAnimation {
                                    duration: 120
                                }
                            }
                        }
                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            spacing: 10
                            Item {
                                width: 28
                                height: 28
                                property bool iconLoaded: !modelData.isCalculator && iconImg.status === Image.Ready && iconImg.source !== "" && iconImg.status !== Image.Error
                                Image {
                                    id: iconImg
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                    smooth: true
                                    cache: false
                                    asynchronous: true
                                    source: modelData.isCalculator ? "qrc:/icons/calculate.svg" : Quickshell.iconPath(modelData.icon, "")
                                    visible: modelData.isCalculator || parent.iconLoaded
                                }
                                Text {
                                    anchors.centerIn: parent
                                    visible: !modelData.isCalculator && !parent.iconLoaded
                                    text: "broken_image"
                                    font.family: "Material Symbols Outlined"
                                    font.pixelSize: 22
                                    color: Theme.accentPrimary
                                }
                            }
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 1
                                Text {
                                    text: modelData.name
                                    color: hovered || isSelected ? Theme.onAccent : Theme.textPrimary
                                    font.pixelSize: 14
                                    font.bold: hovered || isSelected
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                }
                                Text {
                                    text: modelData.isCalculator ? (modelData.expr + " = " + modelData.result) : (modelData.comment || modelData.genericName || "")
                                    color: hovered || isSelected ? Theme.onAccent : Theme.textSecondary
                                    font.pixelSize: 11
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                }
                            }
                            Item {
                                Layout.fillWidth: true
                            }
                            Text {
                                text: modelData.isCalculator ? "content_copy" : "chevron_right"
                                font.family: "Material Symbols Outlined"
                                font.pixelSize: 16
                                color: hovered || isSelected ? Theme.onAccent : Theme.textSecondary
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        Rectangle {
                            id: ripple
                            anchors.fill: parent
                            color: Theme.onAccent
                            opacity: 0.0
                        }
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                ripple.opacity = 0.18;
                                rippleNumberAnimation.start();
                                root.selectedIndex = index; // update selection on click
                                root.activateSelected();
                            }
                            onPressed: ripple.opacity = 0.18
                            onReleased: ripple.opacity = 0.0
                        }
                        NumberAnimation {
                            id: rippleNumberAnimation
                            target: ripple
                            property: "opacity"
                            to: 0.0
                            duration: 320
                        }
                        // Divider (except last item)
                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            height: 1
                            color: Theme.outline
                            opacity: index === appList.count - 1 ? 0 : 0.10
                        }
                    }
                }
            }
        }
    }

    // Corners {
    //     id: launcherCornerRight
    //     position: "bottomleft"
    //     size: 1.1
    //     fillColor: Theme.backgroundPrimary
    //     anchors.top: root.top
    //     offsetX: 397
    //     offsetY: 0
    // }
    //
    // Corners {
    //     id: launcherCornerLeft
    //     position: "bottomright"
    //     size: 1.1
    //     fillColor: Theme.backgroundPrimary
    //     anchors.top: root.top
    //     offsetX: -397
    //     offsetY: 0
    // }
}
