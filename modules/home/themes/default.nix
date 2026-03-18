# Theme application module
# This module reads the active theme and exposes it to all other modules
{
  config,
  lib,
  pkgs,
  ...
}: let
  themes = import ../../lib/themes.nix;
  activeThemeName = "ryo-yamada"; # Change this to switch themes
  activeTheme = themes.${activeThemeName};
in {
  options.theme = {
    active = lib.mkOption {
      type = lib.types.attrs;
      description = "The currently active theme configuration";
      default = activeTheme;
    };

    name = lib.mkOption {
      type = lib.types.str;
      description = "Name of the active theme";
      default = activeTheme.name;
    };
  };

  config = {
    # Make the theme available to all modules
    theme.active = activeTheme;
    theme.name = activeThemeName;
  };
}
