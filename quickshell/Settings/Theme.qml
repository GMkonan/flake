// Theme.qml
pragma Singleton
import QtQuick

QtObject {
    property string currentTheme: "catppuccin-mocha"

    property var themes: ({
            "default": {
                backgroundPrimary: "#0C0D11",
                backgroundSecondary: "#151720",
                backgroundTertiary: "#1D202B",
                surface: "#1A1C26",
                surfaceVariant: "#2A2D3A",
                textPrimary: "#CACEE2",
                textSecondary: "#B7BBD0",
                textDisabled: "#6B718A",
                accentPrimary: "#A8AEFF",
                accentSecondary: "#9EA0FF",
                accentTertiary: "#8EABFF",
                error: "#FF6B81",
                warning: "#FFBB66",
                highlight: "#E3C2FF",
                rippleEffect: "#F3DEFF",
                onAccent: "#1A1A1A",
                outline: "#44485A",
                shadow: "#000000B3",
                overlay: "#11121ACC"
            },
            "catppuccin-mocha": {
                backgroundPrimary: "#1e1e2e",
                backgroundSecondary: "#181825",
                backgroundTertiary: "#11111b",
                surface: "#313244",
                surfaceVariant: "#45475a",
                textPrimary: "#cdd6f4",
                textSecondary: "#a6adc8",
                textDisabled: "#585b70",
                accentPrimary: "#b4befe",
                accentSecondary: "#89b4fa",
                accentTertiary: "#94e2d5",
                error: "#f38ba8",
                warning: "#fab387",
                highlight: "#f9e2af",
                rippleEffect: "#f5c2e7",
                onAccent: "#1e1e2e",
                outline: "#45475a",
                shadow: "#000000B3",
                overlay: "#11111bCC"
            }
        })

    // Backgrounds
    readonly property color backgroundPrimary: themes[currentTheme].backgroundPrimary
    readonly property color backgroundSecondary: themes[currentTheme].backgroundSecondary
    readonly property color backgroundTertiary: themes[currentTheme].backgroundTertiary

    // Surfaces & Elevation
    readonly property color surface: themes[currentTheme].surface
    readonly property color surfaceVariant: themes[currentTheme].surfaceVariant

    // Text Colors
    readonly property color textPrimary: themes[currentTheme].textPrimary
    readonly property color textSecondary: themes[currentTheme].textSecondary
    readonly property color textDisabled: themes[currentTheme].textDisabled

    // Accent Colors
    readonly property color accentPrimary: themes[currentTheme].accentPrimary
    readonly property color accentSecondary: themes[currentTheme].accentSecondary
    readonly property color accentTertiary: themes[currentTheme].accentTertiary

    // Error/Warning
    readonly property color error: themes[currentTheme].error
    readonly property color warning: themes[currentTheme].warning

    // Highlights & Focus
    readonly property color highlight: themes[currentTheme].highlight
    readonly property color rippleEffect: themes[currentTheme].rippleEffect

    // Additional Theme Properties
    readonly property color onAccent: themes[currentTheme].onAccent
    readonly property color outline: themes[currentTheme].outline

    // Shadows & Overlays
    readonly property color shadow: themes[currentTheme].shadow
    readonly property color overlay: themes[currentTheme].overlay
}
