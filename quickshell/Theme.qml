pragma Singleton

import QtQuick
import Quickshell

Singleton {
    property Item get: catppuccin

    Item {
        id: catppuccin

        property string transparentBg: "#aa1E1E2E"
        property string bg: "#1E1E2E"
        // Catppuccin Mocha color palette
        property string barBgColor: "#aa1E1E2E"  // Base
        property string buttonBorderColor: "#313244"  // Surface0
        property string buttonBackgroundColor: "#313244"  // Surface0
        property bool buttonBorderShadow: true
        property bool onTop: true
        property string iconColor: "#89B4FA"  // Blue
        property string iconPressedColor: "#74C7EC"  // Sapphire

        // Backgrounds
        property string backgroundColor: "#1E1E2E"       // Catppuccin Mocha: Base - The main background color
        property string backgroundStrongColor: "#313244" // Catppuccin Mocha: Surface0 - For elements that stand out slightly from the background (e.g., cards, buttons)
        property string backgroundLighterColor: "#45475A"// Catppuccin Mocha: Surface1 - For elements even lighter than backgroundStrongColor

        // Foregrounds (Text and Icons)
        property string foregroundColor: "#CDD6F4"       // Catppuccin Mocha: Text - Main text color
        property string foregroundSubtleColor: "#BAC2DE" // Catppuccin Mocha: Subtext1 - For less prominent text
        property string foregroundMutedColor: "#A6ADC8"  // Catppuccin Mocha: Subtext0 - For muted or placeholder text

        // Primary/Accent Colors
        property string primaryColor: "#89B4FA"          // Catppuccin Mocha: Blue - Main accent color, for interactive elements
        property string primaryPressedColor: "#74C7EC"   // Catppuccin Mocha: Sapphire - A variation for pressed states of primary elements
        property string primaryHoverColor: "#B4BEFE"     // Catppuccin Mocha: Lavender - A lighter shade for hover states (or another accent)

        // Destructive/Error Colors
        property string destructiveColor: "#F38BA8"      // Catppuccin Mocha: Red - For error messages, delete actions
        property string destructiveHoverColor: "#F5C2E7" // Catppuccin Mocha: Pink - A variation for hover states on destructive elements

        // Border Colors
        property string borderColor: "#45475A"           // Catppuccin Mocha: Surface1 - General border color
        property string borderStrongColor: "#585B70"     // Catppuccin Mocha: Surface2 - Stronger border color for emphasis

        // Other Utility Colors (examples, you can add more)
        property string successColor: "#A6DA95"          // Catppuccin Mocha: Green - For success messages
        property string warningColor: "#F9E2AF"          // Catppuccin Mocha: Yellow - For warning messages
        property string infoColor: "#94E2D5"             // Catppuccin Mocha: Teal - For informational messages

    }

    Item {
        id: windowsXP

        property string barBgColor: "#88235EDC"
        property string buttonBorderColor: "#99000000"
        property bool buttonBorderShadow: false
        property string buttonBackgroundColor: "#1111CC"
        property bool onTop: false
        property string iconColor: "green"
        property string iconPressedColor: "green"
        property Gradient barGradient: black.barGradient
    }

    Item {
        id: black

        property string barBgColor: "#cc000000"
        property string buttonBorderColor: "#BBBBBB"
        property string buttonBackgroundColor: "#222222"
        property bool buttonBorderShadow: true
        property bool onTop: true
        property string iconColor: "blue"
        property string iconPressedColor: "dark_blue"
    }

    Item {
        id: nordic

        // Nord color palette
        property string barBgColor: "#aa2E3440"  // Nord0 - Polar Night
        property string buttonBorderColor: "#4C566A"  // Nord3 - Polar Night
        property string buttonBackgroundColor: "#3D4550"
        property bool buttonBorderShadow: true
        property bool onTop: true
        property string iconColor: "#88C0D0"  // Nord7 - Frost
        property string iconPressedColor: "#81A1C1"  // Nord9 - Frost
    }

    Item {
        id: cyberpunk

        // Tokyo Neon color palette
        property string barBgColor: "#881A0B2E"  // Deep purple-black
        property string buttonBorderColor: "#FF2A6D"  // Neon pink
        property string buttonBackgroundColor: "#1A1A2E"  // Dark blue-black
        property bool buttonBorderShadow: true
        property bool onTop: true
        property string iconColor: "#05D9E8"  // Electric blue
        property string iconPressedColor: "#FF2A6D"  // Neon pink
    }

    Item {
        id: material

        // Material Design 3 color palette
        property string barBgColor: "#cc1F1F1F"  // Surface dark
        property string buttonBorderColor: "#2D2D2D"  // Surface variant
        property string buttonBackgroundColor: "#2D2D2D"  // Surface variant
        property bool buttonBorderShadow: true
        property bool onTop: true
        property string iconColor: "#90CAF9"  // Primary light
        property string iconPressedColor: "#64B5F6"  // Primary medium
    }
}
