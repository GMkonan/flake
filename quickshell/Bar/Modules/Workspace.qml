import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Io
import qs.Settings
import qs.Services

Item {
    id: root

    property ListModel workspaces: ListModel {}
    property bool isDestroying: false
    property bool hovered: false

    signal workspaceChanged(int workspaceId, color accentColor)

    property real masterProgress: 0.0
    property bool effectsActive: false
    property color effectColor: Theme.accentPrimary

    property int horizontalPadding: 16
    property int spacingBetweenPills: 8

    width: {
        let total = 0;
        for (let i = 0; i < workspaces.count; i++) {
            const ws = workspaces.get(i);
            if (ws.isFocused)
                total += 44;
            else if (ws.isActive)
                total += 28;
            else
                total += 16;
        }
        total += Math.max(workspaces.count - 1, 0) * spacingBetweenPills;
        total += horizontalPadding * 2;
        return total;
    }

    height: 36

    Component.onCompleted: updateWorkspaceList()
    Connections {
        target: Niri
        function onWorkspacesChanged() {
            updateWorkspaceList();
        }
        function onFocusedWorkspaceIndexChanged() {
            updateWorkspaceFocus();
        }
    }

    function triggerUnifiedWave() {
        effectColor = Theme.accentPrimary;
        masterAnimation.restart();
    }

    SequentialAnimation {
        id: masterAnimation
        PropertyAction {
            target: root
            property: "effectsActive"
            value: true
        }
        NumberAnimation {
            target: root
            property: "masterProgress"
            from: 0.0
            to: 1.0
            duration: 1000
            easing.type: Easing.OutQuint
        }
        PropertyAction {
            target: root
            property: "effectsActive"
            value: false
        }
        PropertyAction {
            target: root
            property: "masterProgress"
            value: 0.0
        }
    }

    function updateWorkspaceList() {
        const newList = Niri.workspaces || [];
        workspaces.clear();
        for (let i = 0; i < newList.length; i++) {
            const ws = newList[i];
            workspaces.append({
                id: ws.id,
                idx: ws.idx,
                name: ws.name || "",
                output: ws.output,
                isActive: ws.is_active,
                isFocused: ws.is_focused,
                isUrgent: ws.is_urgent
            });
        }
        updateWorkspaceFocus();
    }

    function updateWorkspaceFocus() {
        const focusedId = Niri.workspaces?.[Niri.focusedWorkspaceIndex]?.id ?? -1;
        for (let i = 0; i < workspaces.count; i++) {
            const ws = workspaces.get(i);
            const isFocused = ws.id === focusedId;
            const isActive = isFocused;
            if (ws.isFocused !== isFocused || ws.isActive !== isActive) {
                workspaces.setProperty(i, "isFocused", isFocused);
                workspaces.setProperty(i, "isActive", isActive);
                if (isFocused) {
                    root.triggerUnifiedWave();
                    root.workspaceChanged(ws.id, Theme.accentPrimary);
                }
            }
        }
    }

    Rectangle {
        id: workspaceBackground
        width: parent.width - 15
        height: 26
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        radius: 12
        color: Theme.surfaceVariant
        border.color: Qt.rgba(Theme.textPrimary.r, Theme.textPrimary.g, Theme.textPrimary.b, 0.1)
        border.width: 1
    }

    Row {
        id: pillRow
        spacing: spacingBetweenPills
        anchors.verticalCenter: workspaceBackground.verticalCenter
        width: root.width - horizontalPadding * 2
        x: horizontalPadding
        Repeater {
            model: root.workspaces
            Rectangle {
                id: workspacePill
                height: 12
                width: {
                    if (model.isFocused)
                        return 44;
                    else if (model.isActive)
                        return 28;
                    else
                        return 16;
                }
                radius: {
                    if (model.isFocused)
                        return 12;
                    else
                        // half of focused height (if you want to animate this too)
                        return 6;
                }
                color: {
                    if (model.isFocused)
                        return Theme.accentPrimary;
                    if (model.isActive)
                        return Theme.accentPrimary.lighter(130);
                    if (model.isUrgent)
                        return Theme.error;
                    return Qt.lighter(Theme.surfaceVariant, 1.6);
                }
                scale: model.isFocused ? 1.0 : 0.9
                z: 0
                // Material 3-inspired smooth animation for width, height, scale, color, opacity, and radius
                Behavior on width {
                    NumberAnimation {
                        duration: 350
                        easing.type: Easing.OutBack
                    }
                }
                Behavior on height {
                    NumberAnimation {
                        duration: 350
                        easing.type: Easing.OutBack
                    }
                }
                Behavior on scale {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                    }
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                        easing.type: Easing.InOutCubic
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutCubic
                    }
                }
                Behavior on radius {
                    NumberAnimation {
                        duration: 350
                        easing.type: Easing.OutBack
                    }
                }
                // Burst effect overlay for focused pill (smaller outline)
                Rectangle {
                    id: pillBurst
                    anchors.centerIn: parent
                    width: parent.width + 18 * root.masterProgress
                    height: parent.height + 18 * root.masterProgress
                    radius: width / 2
                    color: "transparent"
                    border.color: root.effectColor
                    border.width: 2 + 6 * (1.0 - root.masterProgress)
                    opacity: root.effectsActive && model.isFocused ? (1.0 - root.masterProgress) * 0.7 : 0
                    visible: root.effectsActive && model.isFocused
                    z: 1
                }
            }
        }
    }

    // MouseArea to open/close Applauncher
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (appLauncherPanel && appLauncherPanel.visible) {
                appLauncherPanel.hidePanel();
            } else if (appLauncherPanel) {
                appLauncherPanel.showAt();
            }
        }
        z: 1000 // ensure it's above other content
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
    }

    Component.onDestruction: {
        root.isDestroying = true;
    }
}
