{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''

      device {
              name=syna8020:00-06cb:ce5c-touchpad
              sensitivity=0.3
            }

    '';
    settings = {
      "$mod" = "ALT";

      monitor = [
        # "desc:Samsung Electric Company LU28R55 HX5W500759 ,preferred,1920x0,2" # 4k Monitor as primary, at position 1920,0 to be on the right of 1080p monitor
        # "desc:AOC 24G2W1G4 UKCN4XA003806,highrr,0x0,1" # 1080p Monitor as secondary, at position 0,0
        # "eDP-1,preferred,auto,1" # Position laptop screen to the right

        ",preferred,auto,1" # Position any random new monitor to the right

        # "HDMI-A-1,preferred,auto,1" # HDMI 4k Monitor
      ];

      animations = {
        enabled = false; # Completely disable all animations
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        # "col.active_border" = "rgba(7287fdff)";
        # "col.inactive_border" = "rgba(595959aa)";
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

      exec-once = ["qs" "kanshi"];

      # decoration = {
      #   rounding = 16;
      # };

      bind = [
        "ALT, Return, exec, ${pkgs.ghostty}/bin/ghostty"
        "ALT, Q, killactive,"
        # "ALT SHIFT, E, exit,"
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

        # Windows
        "ALT, 1, workspace, 1" # Code / Terminal
        "ALT, 2, workspace, 2" # Zen
        "ALT, 3, workspace, 3" # Slack / Discord
        "ALT, 4, workspace, 4" # Todo List
        "ALT, 5, workspace, 5" # second monitor browser
        "ALT, 6, workspace, 6" # Terminal
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

        "ALT SHIFT, P, exec, pkill quickshell && hyprctl dispatch exec qs"
        "ALT SHIFT, T, exec, hyprctl dispatch exec kanshi"

        "ALT SHIFT, A, exec, hyprctl switchxkblayout current next"

        "ALT SHIFT, G, togglefloating,"
        "ALT SHIFT, G, centerwindow,"
        "ALT SHIFT, F, fullscreen,"
        # "ALT, L, keyboard, switchxkblayout next"

        ",XF86MonBrightnessUp,exec,brightnessctl set +10%"

        ",XF86MonBrightnessDown,exec,brightnessctl set 10%-"
      ];
    };
  };

  home.packages = with pkgs; [
    wofi
    hyprshot
  ];
}
