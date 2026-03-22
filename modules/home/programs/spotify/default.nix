{
  config,
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  themeName =
    if config ? theme
    then config.theme.name
    else null;

  spicetifyTheme =
    if themeName == "tokyo-night"
    then {
      colorScheme = "mocha";
      extensions = [
        "adblockify"
        "hidePodcasts"
        "shuffle"
      ];
      theme = "catppuccin";
    }
    else {
      colorScheme = "mocha";
      extensions = [];
      theme = "catppuccin";
    };
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  programs.spicetify = {
    enable = true;
    colorScheme = spicetifyTheme.colorScheme;
    enabledExtensions = builtins.map (name: builtins.getAttr name spicePkgs.extensions) spicetifyTheme.extensions;
    theme = builtins.getAttr spicetifyTheme.theme spicePkgs.themes;
  };
}
