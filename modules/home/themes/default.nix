{lib, ...}: let
  themes = {
    ryo-yamada = {
      name = "ryo-yamada";
      description = "A Tokyo Night inspired theme for the ryo host";

      # Custom base16 scheme with exact Tokyo Night colors
      base16Scheme = {
        scheme = "Ryo Yamada Tokyo Night";
        author = "Custom";
        base00 = "#1a1b26"; # background
        base01 = "#16161e"; # surface variant
        base02 = "#24283b"; # surface
        base03 = "#353D57"; # outline
        base04 = "#9aa5ce"; # muted text
        base05 = "#c0caf5"; # text
        base06 = "#a9b1d6"; # light text
        base07 = "#ffffff"; # white
        base08 = "#f7768e"; # error/red
        base09 = "#e0af68"; # warning/yellow
        base0A = "#e0af68"; # types/yellow
        base0B = "#9ece6a"; # success/green
        base0C = "#7dcfff"; # info/cyan
        base0D = "#7aa2f7"; # primary/blue
        base0E = "#bb9af7"; # secondary/purple
        base0F = "#f7768e"; # error
      };

      # Tokyo Night color palette
      colors = {
        # Background colors
        background = "#1a1b26"; # base00 - Default Background
        surface = "#24283b"; # base01 - Lighter Background
        surfaceVariant = "#414868"; # base02 - Selection Background

        # Text colors
        text = "#a9b1d6"; # base05 - Default Foreground
        textMuted = "#565f89"; # base04 - Dark Foreground
        textDisabled = "#414868"; # base03 - Comments

        # Accent colors
        primary = "#7aa2f7"; # base0D - Blue (Functions)
        secondary = "#bb9af7"; # base0E - Purple (Keywords)
        accent = "#9ece6a"; # base0B - Green (Strings)
        warning = "#e0af68"; # base0A - Yellow (Types)
        error = "#f7768e"; # base08 - Red (Variables)
        info = "#7dcfff"; # base0C - Cyan (Constants)

        # Extra accent colors for UI elements
        magenta = "#bb9af7"; # Purple
        orange = "#ff9e64"; # base09 - Orange
      };

      paths = {
        profilePicture = "assets/pfps/ryo-pfp.jpg";
        wallpaperDir = "assets/wallpapers";
        defaultWallpaper = "assets/wallpapers/ryo-night-looking-cam.jpg";
      };

      fastfetch = {
        title = "blue";
        key = "magenta";
        info = "green";
        separator = "cyan";
      };
    };
  };

  # Change this to switch themes
  activeThemeName = "ryo-yamada";

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
