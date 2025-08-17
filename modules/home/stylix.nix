{pkgs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;

    # cursor.name = "BreezX-RosePine-Linux";

    # programs that should not be styled
    targets.waybar.enable = false;
    targets.vscode.enable = false;
    # targets.spicetify.enable = false;
  };

  # stylix.image = ../wallpapers/city.png;
}
