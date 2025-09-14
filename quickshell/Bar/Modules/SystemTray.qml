import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray

Row {
    property var bar
    property var shell
    property var trayMenu
    spacing: 8
    Layout.alignment: Qt.AlignVCenter

    property bool containsMouse: false
    property var systemTray: SystemTray

    Repeater {
        model: systemTray.items
        delegate: Item {
            width: 24
            height: 24
            // Hide Spotify icon, or adjust to your liking
            visible: modelData && modelData.id !== "spotify"
            property bool isHovered: trayMouseArea.containsMouse

            // Hover scale animation
            scale: isHovered ? 1.15 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            // Subtle rotation on hover
            rotation: isHovered ? 5 : 0
            Behavior on rotation {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            Image {
                id: trayIcon
                anchors.centerIn: parent
                width: 18
                height: 18
                sourceSize.width: 18
                sourceSize.height: 18
                smooth: false      // Memory savings
                asynchronous: true
                cache: false
                source: {
                    let icon = modelData?.icon || "";
                    if (!icon)
                        return "";
                    // Process icon path
                    if (icon.includes("?path=")) {
                        const [name, path] = icon.split("?path=");
                        const fileName = name.substring(name.lastIndexOf("/") + 1);
                        return `file://${path}/${fileName}`;
                    }
                    return icon;
                }
                opacity: status === Image.Ready ? 1 : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Component.onCompleted:
                // console.log("Tray icon for", modelData?.id, ":", modelData?.icon)
                {}
            }

            MouseArea {
                id: trayMouseArea
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                onClicked: mouse => {
                    if (!modelData)
                        return;

                    if (mouse.button === Qt.LeftButton) {
                        // Close any open menu first
                        if (trayMenu && trayMenu.visible) {
                            trayMenu.hideMenu();
                        }

                        if (!modelData.onlyMenu) {
                            modelData.activate();
                        }
                    } else if (mouse.button === Qt.MiddleButton) {
                        // Close any open menu first
                        if (trayMenu && trayMenu.visible) {
                            trayMenu.hideMenu();
                        }

                        modelData.secondaryActivate && modelData.secondaryActivate();
                    } else if (mouse.button === Qt.RightButton) {
                        console.log("Right click on", modelData.id, "hasMenu:", modelData.hasMenu, "menu:", modelData.menu);

                        // If menu is already visible, close it
                        if (trayMenu && trayMenu.visible) {
                            trayMenu.hideMenu();
                            return;
                        }

                        if (modelData.hasMenu && modelData.menu && trayMenu) {
                            // Anchor the menu to the tray icon item (parent) and position it below the icon
                            const menuX = (width / 2) - (trayMenu.width / 2);
                            const menuY = height + 20;
                            trayMenu.menu = modelData.menu;
                            trayMenu.showAt(parent, menuX, menuY);
                        } else
                        // console.log("No menu available for", modelData.id, "or trayMenu not set")
                        {}
                    }
                }
            }

            Component.onDestruction:
            // No cache cleanup needed
            {}
        }
    }
}
