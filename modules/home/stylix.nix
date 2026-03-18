{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    # Use the active theme's base16 scheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;

    # cursor.name = "BreezX-RosePine-Linux";

    # programs that should not be styled
    targets.vscode.enable = false;
  };

  # stylix.image = ../wallpapers/city.png;
}
