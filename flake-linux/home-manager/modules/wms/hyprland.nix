{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    settings = {
      "$mod" = "SUPER";
      
debug = {
        disable_logs = true;
        enable_stdout_logs = true;
      };

      exec-once = [
        # what is swww again?
        # "swww init"
        # "swww img ~/Downloads/nixos-chan.png"
        "waybar"
        # "wl-paste --type text --watch cliphist store"
        # "wl-paste --type image --watch cliphist store"
      ];

    bind =
      [
        "$mod, F, exec, firefox"

        ", Print, exec, grimblast copy area"

        "$mod, D, exec, wofi --show drun"
        "$mod, Return, exec, kitty"
        "$mod, B, exec, brave"

        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, T, togglefloating,"

        # Move focus with mod + arrow keys
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"

        # Moving windows
        "$mod SHIFT, left,  swapwindow, l"
        "$mod SHIFT, right, swapwindow, r"
        "$mod SHIFT, up,    swapwindow, u"
        "$mod SHIFT, down,  swapwindow, d"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };
  };
}
