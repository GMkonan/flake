{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        # ",preferred,auto,1
        "DP-1,preferred,0x0,2"     # DisplayPort monitor as primary, at position 0,0
        "eDP-1,preferred,auto,1"  # Position laptop screen to the right or below

      ];
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };
      
      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };
      exec-once = ["waybar"];
      
      bind = [
        "ALT, Return, exec, ${pkgs.ghostty}/bin/ghostty"
        "ALT, Q, killactive,"
        "ALT SHIFT, E, exit,"
        "ALT, R, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "ALT, left, movefocus, l"
        "ALT, right, movefocus, r"
        "ALT, up, movefocus, u"
        "ALT, down, movefocus, d"
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
      ];

    };
  };

  home.packages = with pkgs; [
    wofi
  ];
}
