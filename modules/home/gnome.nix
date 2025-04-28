{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
    gnomeExtensions.workspace-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    # Add other GNOME-related packages here
  ];

  dconf.settings = {
    # Shell settings
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
      ];
      favorite-apps = [
        "zen.desktop"
        "Ghostty.desktop"
        "org.gnome.Nautilus.desktop"
        "code.desktop"
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
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      extend-height = true;
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      multi-monitor = false;
      height-fraction = 0.9;
    };
  };

  # GNOME-related services
  services = {
    gpg-agent.enable = true;
    gnome-keyring.enable = true;
  };

  # Additional GNOME-related configurations can go here
}
