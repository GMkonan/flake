import QtQuick
import Quickshell
import qs.Bar.Modules
import qs.Settings
import qs.Services
import qs.Components
import qs.Widgets
import qs.Widgets.Sidebar
import qs.Widgets.Sidebar.Panel
import QtQuick.Controls

Scope {
    id: rootScope
    property var shell

    Item {
        id: barRootItem
        anchors.fill: parent

        Variants {
            model: Quickshell.screens

            Item {
                property var modelData

                PanelWindow {
                    id: panel
                    screen: modelData
                    color: "transparent"
                    implicitHeight: barBackground.height + 24
                    anchors.top: true
                    anchors.left: true
                    anchors.right: true

                    visible: true

                    property string lastFocusedWindowTitle: ""
                    property bool activeWindowVisible: false
                    property string displayedWindowTitle: ""

                    onLastFocusedWindowTitleChanged: {
                        displayedWindowTitle = (lastFocusedWindowTitle === "(No active window)") ? "" : lastFocusedWindowTitle;
                    }

                    Timer {
                        id: hideTimer
                        interval: 4000
                        repeat: false
                        onTriggered: panel.activeWindowVisible = false
                    }

                    Connections {
                        target: Niri
                        function onFocusedWindowTitleChanged() {
                            var newTitle = Niri.focusedWindowTitle;

                            if (newTitle !== panel.lastFocusedWindowTitle) {
                                panel.lastFocusedWindowTitle = newTitle;

                                if (newTitle === "(No active window)") {
                                    panel.activeWindowVisible = false;
                                    hideTimer.stop();
                                } else {
                                    panel.activeWindowVisible = true;
                                    hideTimer.restart();
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: barBackground
                        width: parent.width
                        height: 36
                        color: Theme.backgroundPrimary
                        anchors.top: parent.top
                        anchors.left: parent.left
                    }

                    ActiveWindow {}

                    Workspace {
                        id: workspace
                        anchors.horizontalCenter: barBackground.horizontalCenter
                        anchors.verticalCenter: barBackground.verticalCenter
                    }

                    Row {
                        id: rightWidgetsRow
                        anchors.verticalCenter: barBackground.verticalCenter
                        anchors.right: barBackground.right
                        anchors.rightMargin: 18
                        spacing: 12

                        Brightness {
                            id: widgetsBrightness
                        }

                        Volume {
                            id: widgetsVolume
                            shell: rootScope.shell
                        }

                        Battery {
                            id: widgetsBattery
                        }

                        SystemTray {
                            id: systemTrayModule
                            shell: rootScope.shell
                            bar: panel
                            trayMenu: externalTrayMenu
                        }

                         CustomTrayMenu {
                             id: externalTrayMenu
                         }

                         ClockWidget {}

                        PanelPopup {
                            id: sidebarPopup
                        }

                        Button {
                            barBackground: barBackground
                            screen: modelData
                            sidebarPopup: sidebarPopup
                        }
                    }

                    Corners {
                        id: topleftCorner
                        position: "bottomleft"
                        size: 1.3
                        fillColor: (Theme.backgroundPrimary !== undefined && Theme.backgroundPrimary !== null) ? Theme.backgroundPrimary : "#222"
                        offsetX: -39
                        offsetY: 0
                        anchors.top: barBackground.bottom
                    }

                    Corners {
                        id: toprightCorner
                        position: "bottomright"
                        size: 1.3
                        fillColor: (Theme.backgroundPrimary !== undefined && Theme.backgroundPrimary !== null) ? Theme.backgroundPrimary : "#222"
                        offsetX: 39
                        offsetY: 0
                        anchors.top: barBackground.bottom
                    }

                    Background {}
                    Overview {}
                }
            }
        }
    }

    // This alias exposes the visual bar's visibility to the outside world
    property alias visible: barRootItem.visible
}
