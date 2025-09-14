pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<var> workspaces: []
    property int focusedWorkspaceIndex: 0
    property list<var> windows: []
    property int focusedWindowIndex: 0
    property bool inOverview: false

    // Reactive property for focused window title
    property string focusedWindowTitle: "(No active window)"

    // Update the focusedWindowTitle whenever relevant properties change
    function updateFocusedWindowTitle() {
        if (focusedWindowIndex >= 0 && focusedWindowIndex < windows.length) {
            focusedWindowTitle = windows[focusedWindowIndex].title || "(Unnamed window)";
        } else {
            focusedWindowTitle = "(No active window)";
        }
    }

    // Call updateFocusedWindowTitle on changes
    onWindowsChanged: updateFocusedWindowTitle()
    onFocusedWindowIndexChanged: updateFocusedWindowTitle()

    Process {
        command: ["niri", "msg", "-j", "event-stream"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const event = JSON.parse(data.trim());

                if (event.WorkspacesChanged) {
                    root.workspaces = [...event.WorkspacesChanged.workspaces].sort((a, b) => a.idx - b.idx);
                    root.focusedWorkspaceIndex = root.workspaces.findIndex(w => w.is_focused);
                    if (root.focusedWorkspaceIndex < 0) {
                        root.focusedWorkspaceIndex = 0;
                    }
                } else if (event.WorkspaceActivated) {
                    root.focusedWorkspaceIndex = root.workspaces.findIndex(w => w.id === event.WorkspaceActivated.id);
                    if (root.focusedWorkspaceIndex < 0) {
                        root.focusedWorkspaceIndex = 0;
                    }
                } else if (event.WindowsChanged) {
                    root.windows = [...event.WindowsChanged.windows].sort((a, b) => a.id - b.id);
                    //const window = event.WindowOpenedOrChanged.window;
                    //                    const index = root.windows.findIndex(w => w.id === window.id);
                    // if (index >= 0) {
                    //     root.windows[index] = window;
                    // } else {
                    //     root.windows.push(window);
                    //     root.windows = [...root.windows].sort((a, b) => a.id - b.id);
                    //     if (window.is_focused) {
                    //         root.focusedWindowIndex = root.windows.findIndex(w => w.id === window.id);
                    //         if (root.focusedWindowIndex < 0) {
                    //             root.focusedWindowIndex = 0;
                    //         }
                    //     }
                    // }
                } else if (event.WindowClosed) {
                    root.windows = [...root.windows.filter(w => w.id !== event.WindowClosed.id)];
                } else if (event.WindowFocusChanged) {
                    if (event.WindowFocusChanged.id) {
                        root.focusedWindowIndex = root.windows.findIndex(w => w.id === event.WindowFocusChanged.id);
                        if (root.focusedWindowIndex < 0) {
                            root.focusedWindowIndex = 0;
                        }
                        const focusedWin = root.windows[root.focusedWindowIndex];
                        "title:", focusedWin ? `"${focusedWin.title}"` : "<none>";
                    } else {
                        root.focusedWindowIndex = -1;
                    }
                } else if (event.OverviewOpenedOrClosed) {
                    root.inOverview = event.OverviewOpenedOrClosed.is_open;
                }
            }
        }
    }
}
