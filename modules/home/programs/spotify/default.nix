{
  config,
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  spicetifyTheme = config.theme.active.apps.spicetify;
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
