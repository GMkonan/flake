{pkgs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    # programs that should not be styled
    targets.waybar.enable = false;
  };

  # stylix.image = ../wallpapers/city.png;
}
