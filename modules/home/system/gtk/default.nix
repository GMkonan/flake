{config, ...}: {
  # GTK theming with Catppuccin
  gtk = {
    enable = true;

    # Additional GTK settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = config.theme.active.stylix.polarity == "dark";
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = config.theme.active.stylix.polarity == "dark";
    };
  };
}
