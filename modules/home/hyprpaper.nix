{
  pkgs,
  lib,
  ...
}:
with lib;
with builtins; let
  theme = {
    name = "catppuccin-mocha"; 
    wallpapers = ../../wallpapers;
  };
  themedWallpaper = wallpaper:
    pkgs.stdenv.mkDerivation rec {
      name = "${theme.name}-${baseNameOf wallpaper}";
      nativeBuildInputs = [pkgs.lutgen];
      phases = ["buildPhase" "installPhase"];
      buildPhase = ''
        cp ${wallpaper} ./${name}
        lutgen apply -p ${theme.name} ${name} -o themed
      '';
      installPhase = ''
        cp themed/${name} $out
      '';
    };
  wallpapers = filesystem.listFilesRecursive theme.wallpapers;
  themedWallpapers = listToAttrs (map (wallpaper: {
      name = "${baseNameOf wallpaper}";
      value = themedWallpaper wallpaper;
    })
    wallpapers);
  wallpaperBashArray = "(\"${strings.concatStrings (strings.intersperse "\" \"" (map (wallpaper: "${wallpaper}") (attrValues themedWallpapers)))}\")";
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
  # Add lutgen and hyprpaper explicitly to home.packages
  home.packages = with pkgs; [
    wallpaperRandomizer
    lutgen
    hyprpaper
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
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
