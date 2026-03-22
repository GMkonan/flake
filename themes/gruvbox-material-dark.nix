{
  lib,
  pkgs,
  ...
}: let
  theme = rec {
    name = "gruvbox-material-dark";
    description = "Gruvbox Material dark theme shared across Stylix and home modules";

    ui = {
      rounding = 30;
      gapsIn = 12;
      gapsOut = 24;
      activeOpacity = 0.96;
      inactiveOpacity = 0.94;
      blur = true;
      borderSize = 4;
      animationSpeed = "fast";
      textColorOnWallpaper = "#282828";
    };

    base16Scheme = {
      scheme = "Gruvbox Material Dark";
      author = "Konan";
      base00 = "282828";
      base01 = "32302f";
      base02 = "504945";
      base03 = "665c54";
      base04 = "7c6f64";
      base05 = "ddc7a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "ea6962";
      base09 = "e78a4e";
      base0A = "d8a657";
      base0B = "a9b665";
      base0C = "89b482";
      base0D = "7daea3";
      base0E = "d3869b";
      base0F = "bd6f3e";
    };

    colors = {
      background = "#282828";
      surface = "#32302f";
      surfaceVariant = "#504945";
      text = "#ddc7a1";
      textMuted = "#928374";
      textDisabled = "#665c54";
      primary = "#d8a657";
      secondary = "#d3869b";
      accent = "#a9b665";
      warning = "#e78a4e";
      error = "#ea6962";
      info = "#7daea3";
      magenta = "#d3869b";
      orange = "#e78a4e";
    };

    assets = {
      profilePicture = ../assets/pfps/ryo-pfp.jpg;
      wallpaperDir = ../assets/wallpapers;
      wallpaper = ../assets/wallpapers/asya-1.png;
    };

    programs = {
      git = {
        deltaTheme = "gruvbox-dark";
      };

      nvim = {
        plugin = "gruvbox-material";
        colorscheme = "gruvbox-material";
        siliconTheme = "gruvbox-dark";
      };

      spicetify = {
        colorScheme = "mocha";
        extensions = [
          "adblockify"
          "hidePodcasts"
          "shuffle"
        ];
        theme = "catppuccin";
      };
    };

    stylix = {
      enable = true;
      image = ../assets/wallpapers/asya-1.png;
      polarity = "dark";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.roboto;
          name = "Roboto";
        };
        serif = {
          package = pkgs.roboto;
          name = "Roboto";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          applications = 13;
          desktop = 13;
          popups = 13;
          terminal = 13;
        };
      };
    };
  };
in {
  options.theme = {
    active = lib.mkOption {
      type = lib.types.attrs;
      default = theme;
      description = "Expanded configuration for the selected theme";
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = theme.name;
      description = "Name of the active theme";
    };
  };

  config = {
    theme = {
      active = theme;
      name = theme.name;
    };

    stylix = {
      enable = theme.stylix.enable;
      base16Scheme = theme.base16Scheme;
      image = theme.stylix.image;
      inherit (theme.stylix) cursor fonts polarity;
    };
  };
}
