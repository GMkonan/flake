{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
        "blur-my-shell@aunetx"
      ];
      favorite-apps = [
        "zen.desktop"
        "org.gnome.Nautilus.desktop"
        "vesktop.desktop"
        "ticktick.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme =
        if config.theme.active.stylix.polarity == "dark"
        then "prefer-dark"
        else "prefer-light";
      enable-hot-corners = true;
      clock-show-weekday = true;
      clock-show-date = true;
      show-battery-percentage = true;
      text-scaling-factor = 1.0;
    };

    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      show-hidden-files = true;
    };
  };

  services = {
    gnome-keyring.enable = true;
    gpg-agent.enable = true;
  };
}
