{
  config,
  host,
  inputs,
  pkgs,
  ...
}: let
  flakeAsset = path: "${host.paths.flakeDir}/${path}";
in {
  # Pin the separately maintained plugin through flake.lock and expose it as a
  # local Noctalia V5 plugin.
  xdg.dataFile."noctalia/plugins/protonvpn".source = "${inputs.noctalia-protonvpn}/protonvpn";

  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      bar = {
        order = ["widgets"];
        widgets = {
          start = [
            "control-center"
            "workspaces"
            "media"
          ];
          center = [
            "date"
            "clock"
          ];
          end = [
            "tray"
            "notifications"
            "group:g1"
            "protonvpn"
            "session"
          ];
          margin_edge = 0;
          margin_ends = 0;
          radius = 0;
          capsule_group = [
            {
              id = "g1";
              members = [
                "bluetooth"
                "network"
                "volume"
                "battery"
              ];
              fill = "surface_variant";
              opacity = 1.0;
              padding = 6.0;
            }
          ];
        };
      };

      control_center.shortcuts = [
        {type = "wifi";}
        {type = "bluetooth";}
        {type = "caffeine";}
        {type = "notification";}
        {type = "power_profile";}
        {type = "wallpaper";}
      ];

      dock.enabled = false;

      idle.behavior = {
        lock = {
          enabled = true;
          timeout = 1200;
          action = "lock";
        };
        "screen-off" = {
          enabled = true;
          timeout = 1320;
          action = "screen_off";
        };
        suspend = {
          enabled = true;
          timeout = 1800;
          action = "lock_and_suspend";
        };
      };

      location.address = "Vitoria, ES, Brazil";
      lockscreen.enabled = true;

      plugins.enabled = ["gmkonan/protonvpn"];

      shell = {
        avatar_path = flakeAsset config.theme.active.assets.profilePicture;
        panel = {
          control_center_placement = "attached";
          open_near_click_control_center = true;
        };
      };

      theme = {
        mode = "dark";
        shell_mode = "follow";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper.directory = flakeAsset config.theme.active.assets.wallpaperDir;

      widget = {
        battery.show_label = false;
        network.show_label = false;
        protonvpn.type = "gmkonan/protonvpn:bar";
      };
    };
  };
}
