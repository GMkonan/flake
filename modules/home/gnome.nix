# modules/desktop/gnome.nix
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnome.gnome-tweaks
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
        "firefox.desktop"
        "org.gnome.Terminal.desktop"
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

    # Window manager preferences
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      workspace-names = ["Main" "Work" "Communication" "Media"];
      focus-mode = "click";
      num-workspaces = 4;
    };

    # Window manager keybindings
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
    };

    # Mutter settings
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };

    # File manager settings
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      show-hidden-files = true;
    };

    # Terminal settings
    "org/gnome/terminal/legacy/profiles:" = {
      default = "b1dcc9dd-5262-4d8d-a863-c897e6d979b9";
      list = ["b1dcc9dd-5262-4d8d-a863-c897e6d979b9"];
    };

    "org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      audible-bell = false;
      use-system-font = true;
      use-theme-colors = true;
    };

    # Dash to dock settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "LEFT";
      extend-height = true;
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      multi-monitor = true;
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
