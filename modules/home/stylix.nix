{pkgs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    # cursor.package = pkgs.bibata-cursors;

    # cursor.name = "Bibata-Modern-Ice";

    # programs that should not be styled
    targets.waybar.enable = false;
    # targets.spicetify.enable = false;
  };

  # stylix.image = ../wallpapers/city.png;
}
