{
  pkgs,
  lib,
  ...
}:
with lib; let
  theme = {
    # https://github.com/hyprwm/hyprpaper/issues/108#issuecomment-2119611893
    # Maybe add lutgen later
    name = "catppuccin-mocha";
    # either dark or light or both its what I want to do
    # based on time of the day or user preference
    type = "dark";
    wallpapers = ../../../wallpapers + /${theme.type};
  };
  wallpapers = filesystem.listFilesRecursive theme.wallpapers;
  wallpaperBashArray = "(\"${strings.concatStrings (strings.intersperse "\" \"" (map (wallpaper: "${wallpaper}") wallpapers))}\")";
  wallpaperRandomizer = pkgs.writeShellScriptBin "wallpaperRandomizer" ''
    wallpapers=${wallpaperBashArray}
    rand=$[$RANDOM % ''${#wallpapers[@]}]
    wallpaper=''${wallpapers[$rand]}
    monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload $wallpaper
    for m in ''${monitor[@]}; do
      hyprctl hyprpaper wallpaper "$m,$wallpaper"
    done
  '';
in {
  home.packages = with pkgs; [
    wallpaperRandomizer
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["~/flake/wallpapers/dark/space-astronaut.png"];
      wallpaper = [",~/flake/wallpapers/dark/space-astronaut.png"];
    };
  };

  systemd.user = {
    services.wallpaperRandomizer = {
      Install = {WantedBy = ["graphical-session.target"];};
      Unit = {
        Description = "Set random desktop background using hyprpaper";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${wallpaperRandomizer}/bin/wallpaperRandomizer";
        IOSchedulingClass = "idle";
      };
    };
    timers.wallpaperRandomizer = {
      Unit = {Description = "Set random desktop background using hyprpaper on an interval";};
      Timer = {OnUnitActiveSec = "1h";};
      Install = {WantedBy = ["timers.target"];};
    };
  };
}
