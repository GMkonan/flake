{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
    # gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    # Add other GNOME-related packages here
  ];

  dconf.settings = {
    # Shell settings
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        # "dash-to-dock@micxgx.gmail.com"
        "dash-to-panel@jderose9.github.com"
        "blur-my-shell@aunetx"
      ];
      favorite-apps = [
        "zen.desktop"
        # "com.mitchellh.ghostty.desktop"
        "org.gnome.Nautilus.desktop"
        "discord.desktop"
        "ticktick.desktop"
        # "code.desktop"
      ];
    };

    # Interface settings
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
      clock-show-weekday = true;
      clock-show-date = true;
      gtk-theme = "Adwaita-dark";
      show-battery-percentage = true;
    };

    # "org/gnome/mutter" = {
    #   "experimental-features" = ["scale-monitor-framebuffer"];
    # };
    #
    # "org/gnome/desktop/interface" = {
    #   "text-scaling-factor" = 1.0;
    # };
    #
    # "org/gnome/mutter/monitors.xml" = {
    #   "monitors" = [
    #     {
    #       "monitor-name" = "HDMI-1"; # Your 4K monitor
    #       "scale" = 2.0;
    #     }
    #     {
    #       "monitor-name" = "DP-1"; # Your 1080p monitor
    #       "scale" = 1.0;
    #     }
    #   ];
    # };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri-dark = "file://" + ../../wallpapers/night-girl-city-sky.jpeg;
    };

    # File manager settings
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      show-hidden-files = true;
    };

    # Dash to dock settings
    # "org/gnome/shell/extensions/dash-to-dock" = {
    #   dock-position = "BOTTOM";
    #   extend-height = true;
    #   dock-fixed = false;
    #   autohide = true;
    #   intellihide = true;
    #   multi-monitor = false;
    #   height-fraction = 0.9;
    # };

    # Dash to Panel settings
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-position = "BOTTOM";
      panel-size = 32;
      animate-show-apps = true;
      appicon-margin = 8;
      appicon-padding = 4;
      dot-position = "BOTTOM";
      dot-style-focused = "DOTS";
      dot-style-unfocused = "DOTS";
      trans-use-custom-bg = true;
      trans-bg-color = "#241f31";
      hide-overview-on-startup = true;
      hot-keys = true;
      multi-monitors = false;
      hotkeys-overlay-combo = "TEMPORARILY";
      isolate-workspaces = true;
      middle-click-action = "LAUNCH";
      panel-element-positions = ''
        {"0":[
          {"element":"showAppsButton","visible":true,"position":"stackedTL"},
          {"element":"taskbar","visible":true,"position":"centerMonitor"},
          {"element":"leftBox","visible":true,"position":"stackedTL"},
          {"element":"rightBox","visible":true,"position":"stackedBR"},
          {"element":"centerBox","visible":true,"position":"centerMonitor"},
          {"element":"dateMenu","visible":true,"position":"stackedBR"},
          {"element":"systemMenu","visible":true,"position":"stackedBR"}
        ]}
      '';
      show-apps-icon-file = "";
      show-apps-icon-side-padding = 8;
      show-window-previews = true;
      status-icon-padding = -1;
      tray-padding = -1;
      window-preview-title-position = "TOP";
    };
  };

  # GNOME-related services
  services = {
    gpg-agent.enable = true;
    gnome-keyring.enable = true;
  };

  # Additional GNOME-related configurations can go here
}
