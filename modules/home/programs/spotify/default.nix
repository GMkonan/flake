{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  spicetifyTheme = {
    colorScheme = lib.attrByPath ["programs" "spicetify" "colorScheme"] "mocha" (config.theme.active or {});
    extensions = lib.attrByPath ["programs" "spicetify" "extensions"] [] (config.theme.active or {});
    theme = lib.attrByPath ["programs" "spicetify" "theme"] "catppuccin" (config.theme.active or {});
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
