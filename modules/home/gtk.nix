{...}: {
  # GTK theming with Catppuccin
  gtk = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.flavor = "mocha";

    # Additional GTK settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
