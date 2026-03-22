# Niri window manager configuration with themed colors
{config, ...}: let
  theme = config.theme.active;
in {
  xdg.configFile."niri/config.kdl".text = ''
    // This config is in the KDL format: https://kdl.dev
    // "/-" comments out the following node.
    // Check the wiki for a full description of the configuration:
    // https://yalter.github.io/niri/Configuration:-Introduction

    // Input device configuration.
    // Find the full list of options on the wiki:
    // https://yalter.github.io/niri/Configuration:-Input
    input {
        mod-key "Alt"
        mod-key-nested "Super"

        keyboard {
            xkb {
                layout "us,br"
                options "grp:win_space_toggle"
            }
            numlock
        }

        touchpad {
            tap
            natural-scroll
        }

        mouse {
        }

        trackpoint {
        }
    }

    gestures {
        hot-corners {
            off
        }
    }

    workspace "coding"
    workspace "browser"
    workspace "music"
    workspace "socials"

    layout {
        gaps ${toString theme.ui.gapsIn}
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        // Focus ring with themed colors
        focus-ring {
            width ${toString theme.ui.borderSize}
            // Using theme colors
            active-color "${theme.colors.primary}"
            inactive-color "${theme.colors.textMuted}"
        }

        // Border (disabled by default)
        border {
            off
            width ${toString theme.ui.borderSize}
            active-color "${theme.colors.warning}"
            inactive-color "${theme.colors.textMuted}"
            urgent-color "${theme.colors.error}"
        }

        shadow {
            softness ${toString (
      if theme.ui.blur
      then 30
      else 0
    )}
            spread ${toString (
      if theme.ui.blur
      then 5
      else 0
    )}
            offset x=0 y=5
            color "${
      if theme.ui.blur
      then "#0007"
      else "#0000"
    }"
        }

        struts {
        }
    }

    spawn-at-startup "noctalia-shell"

    hotkey-overlay {
        skip-at-startup
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    animations {
    }

    // Window rules
    window-rule {
        match app-id=r#"(code|visual-studio-code|com\.visualstudio\.code)$"#
        match app-id=r#"(zed|Zed|dev\.zed\.Zed)$"#
        open-on-workspace "coding"
        open-maximized true
    }

    window-rule {
        match app-id=r#"(zen|Zen|app\.zen_browser\.zen)$"#
        open-on-workspace "browser"
        open-maximized true
    }

    window-rule {
        match app-id=r#"(spotify|com\.spotify\.Client)$"#
        open-on-workspace "music"
        open-maximized true
    }

    window-rule {
        match app-id=r#"(vesktop|dev\.vesktop\.Vesktop)$"#
        match app-id=r#"(slack|com\.slack\.Slack)$"#
        open-on-workspace "socials"
        open-maximized true
    }

    window-rule {
        match app-id=r#"(bitwarden|com\.bitwarden\.desktop)$"#
        open-floating true
        default-column-width { fixed 900; }
        default-window-height { fixed 650; }
    }

    window-rule {
        match app-id="ghostty"
        opacity 0.9;
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    window-rule {
        clip-to-geometry true
    }

    binds {
        Mod+Shift+T { toggle-window-rule-opacity; }
        Alt+Shift+Slash { show-hotkey-overlay; }

        // Applications
        Mod+Return hotkey-overlay-title="Open a Terminal: Ghostyy" { spawn "ghostty"; }
        Mod+Z hotkey-overlay-title="Run an Application: Zen" { spawn "zen"; }
        Mod+R hotkey-overlay-title="Open List of applications: noctalia launcher" { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
        Mod+P hotkey-overlay-title="Screenshot Region" { spawn "hyprshot" "-m" "region" "--clipboard-only"; }

        // Dictation
        Mod+D hotkey-overlay-title="Dictation: Auto-detect language" { spawn "dictate-auto"; }
        Mod+Shift+D hotkey-overlay-title="Dictation: Portuguese" { spawn "dictate-pt"; }
        Mod+Ctrl+D hotkey-overlay-title="Dictation: English" { spawn "dictate-en"; }

        // Audio
        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        // Brightness
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

        // Window management
        Mod+O repeat=false { toggle-overview; }
        Mod+Q repeat=false { close-window; }

        // Focus
        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        // Move
        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        // Focus first/last
        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        // Monitor focus
        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        // Move to monitor
        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        // Workspaces
        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }
        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        // Wheel
        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }
        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        // Workspaces by number
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        // Column management
        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        // Window sizing
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        // Floating
        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }

        // Tabbed display
        Mod+W { toggle-column-tabbed-display; }

        // Screenshots
        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        // Session
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }
        Mod+Shift+P { power-off-monitors; }
    }
  '';
}
