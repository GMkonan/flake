{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "ALT";

      monitor = [
        # ",preferred,auto,1
        "DP-1,preferred,0x0,2" # DisplayPort monitor as primary, at position 0,0
        "eDP-1,preferred,auto,1" # Position laptop screen to the right
      ];

      animations = {
        enabled = false; # Completely disable all animations
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "rgba(7287fdff)";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
      };

      input = {
        kb_layout = "us,br";
        # kb_options = "grp:alt_shift_toggle"; # Alt+Shift to switch layouts
        # kb_layout = "us";
        # kb_variant = "intl"; # Should probably add abnt2 here
        follow_mouse = 1;
        sensitivity = -0.5;
      };

      device = {
        name = "tpps/2-ibm-trackpoint";
        sensitivity = 0;
      };

      exec-once = ["waybar"];

      decoration = {
        rounding = 16;
      };

      bind = [
        "ALT, Return, exec, ${pkgs.ghostty}/bin/ghostty"
        "ALT, Q, killactive,"
        "ALT SHIFT, E, exit,"
        "ALT, R, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "ALT, Z, exec, zen"
        "ALT, left, movefocus, l"
        "ALT, right, movefocus, r"
        "ALT, up, movefocus, u"
        "ALT, down, movefocus, d"
        "ALT, h, movefocus, l"
        "ALT, l, movefocus, r"
        "ALT, k, movefocus, u"
        "ALT, j, movefocus, d"
        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"

        # Move active window to workspace using Alt + Shift + [0-9]
        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
        "ALT SHIFT, 6, movetoworkspace, 6"
        "ALT SHIFT, 7, movetoworkspace, 7"
        "ALT SHIFT, 8, movetoworkspace, 8"
        "ALT SHIFT, 9, movetoworkspace, 9"
        "ALT SHIFT, 0, movetoworkspace, 10"

        "ALT, period, focusmonitor, +1"
        "ALT, comma, focusmonitor, -1"

        "ALT SHIFT, period, movecurrentworkspacetomonitor, +1"
        "ALT SHIFT, comma, movecurrentworkspacetomonitor, -1"

        "ALT, P, exec, hyprshot -m region --clipboard-only"

        "ALT SHIFT, P, exec, pkill waybar && hyprctl dispatch exec waybar"

        "ALT SHIFT, L, exec, hyprctl switchxkblayout current next"
        # "ALT, L, keyboard, switchxkblayout next"
      ];
    };
  };

  home.packages = with pkgs; [
    wofi
    hyprshot
  ];
}
