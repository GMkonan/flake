{
  lib,
  pkgs,
  ...
}: let
  theme = rec {
    name = "tokyo-night";
    description = "Tokyo Night theme shared across Stylix and home modules";

    ui = {
      rounding = 30;
      gapsIn = 16;
      gapsOut = 24;
      activeOpacity = 0.96;
      inactiveOpacity = 0.94;
      blur = true;
      borderSize = 2;
      animationSpeed = "fast";
      textColorOnWallpaper = "#1a1b26";
    };

    base16Scheme = {
      scheme = "Tokyo Night";
      author = "Konan";
      base00 = "1a1b26";
      base01 = "16161e";
      base02 = "24283b";
      base03 = "353d57";
      base04 = "9aa5ce";
      base05 = "c0caf5";
      base06 = "a9b1d6";
      base07 = "ffffff";
      base08 = "f7768e";
      base09 = "e0af68";
      base0A = "e0af68";
      base0B = "9ece6a";
      base0C = "7dcfff";
      base0D = "7aa2f7";
      base0E = "bb9af7";
      base0F = "f7768e";
    };

    colors = {
      background = "#1a1b26";
      surface = "#24283b";
      surfaceVariant = "#414868";
      text = "#a9b1d6";
      textMuted = "#565f89";
      textDisabled = "#414868";
      primary = "#7aa2f7";
      secondary = "#bb9af7";
      accent = "#9ece6a";
      warning = "#e0af68";
      error = "#f7768e";
      info = "#7dcfff";
      magenta = "#bb9af7";
      orange = "#ff9e64";
    };

    assets = {
      profilePicture = "assets/pfps/ryo-pfp.jpg";
      wallpaperDir = "assets/wallpapers";
      wallpaper = "assets/wallpapers/ryo-night-looking-cam.jpg";
    };

    programs = {
      git = {
        deltaTheme = "OneHalfDark";
      };

      nvim = {
        plugin = "tokyonight";
        colorscheme = "tokyonight-night";
        siliconTheme = "Dracula";
      };

      spicetify = {
        colorScheme = "TokyoNight";
        extensions = [
          "adblockify"
          "hidePodcasts"
          "shuffle"
        ];
        theme = "sleek";
      };
    };

    stylix = {
      enable = true;
      image = ../assets/wallpapers/ryo-night-looking-cam.jpg;
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
