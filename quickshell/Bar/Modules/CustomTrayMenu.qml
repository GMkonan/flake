pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Settings

PopupWindow {
    id: trayMenu
    implicitWidth: 180
    implicitHeight: Math.max(40, listView.contentHeight + 12)
    visible: false
    color: "transparent"

    property QsMenuHandle menu
    property var anchorItem: null
    property real anchorX
    property real anchorY

    anchor.item: anchorItem ? anchorItem : null
    anchor.rect.x: anchorX
    anchor.rect.y: anchorY

    function showAt(item, x, y) {
        if (!item) {
            console.warn("CustomTrayMenu: anchorItem is undefined, not showing menu.");
            return;
        }
        anchorItem = item;
        anchorX = x;
        anchorY = y;
        visible = true;
        forceActiveFocus();
        Qt.callLater(() => trayMenu.anchor.updateAnchor());
    }

    function hideMenu() {
        visible = false;
    }

    Item {
        anchors.fill: parent
        Keys.onEscapePressed: trayMenu.hideMenu()
    }

    QsMenuOpener {
        id: opener
        menu: trayMenu.menu
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        color: Theme.backgroundPrimary
        border.color: Theme.accentPrimary
        border.width: 2
        radius: 20
        z: 0
    }

    ListView {
        id: listView
        anchors.fill: parent
        anchors.margins: 6
        spacing: 2
        interactive: false
        enabled: trayMenu.visible
        clip: true

        model: ScriptModel {
            values: opener.children ? [...opener.children.values] : []
        }

        delegate: Rectangle {
            id: entry
            required property var modelData

            width: listView.width
            height: (modelData?.isSeparator) ? 8 : 28
            color: "transparent"
            radius: 6

            Rectangle {
                anchors.centerIn: parent
                width: parent.width - 20
                height: 1
                color: Qt.darker(Theme.backgroundPrimary, 1.4)
                visible: modelData?.isSeparator ?? false
            }

            Rectangle {
                anchors.fill: parent
                color: mouseArea.containsMouse ? Theme.highlight : "transparent"
                radius: 6
                visible: !(modelData?.isSeparator ?? false)

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 8

                    Text {
                        Layout.fillWidth: true
                        color: (modelData?.enabled ?? true) ? Theme.textPrimary : Theme.textDisabled
                        text: modelData?.text ?? ""
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    Image {
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                        source: modelData?.icon ?? ""
                        visible: (modelData?.icon ?? "") !== ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: (modelData?.enabled ?? true) && !(modelData?.isSeparator ?? false) && trayMenu.visible

                    onClicked: {
                        if (modelData && !modelData.isSeparator) {
                            modelData.triggered();
                            trayMenu.hideMenu();
                        }
                    }
                }
            }
        }
    }
}
