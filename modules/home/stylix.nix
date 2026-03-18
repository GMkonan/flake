{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    # Use the custom base16 scheme from the active theme
    base16Scheme = config.theme.active.base16Scheme;

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # programs that should not be styled
    targets.vscode.enable = false;
  };
}
