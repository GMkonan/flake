# Theme definitions for the Ryo Yamada (Tokyo Night) theme
{
  ryo-yamada = {
    name = "ryo-yamada";
    description = "A Tokyo Night inspired theme for the ryo host";

    # Base16 color scheme to use with stylix
    base16Scheme = "tokyo-night";

    # Tokyo Night color palette extracted from base16-tokyo-night
    # Source: https://github.com/tinted-theming/schemes/blob/spec-0.11/base16/tokyo-night.yaml
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

    # File paths (relative to flake root)
    paths = {
      # Profile picture for noctalia and other apps
      profilePicture = "assets/pfps/ryo-pfp.jpg";

      # Wallpaper directory for noctalia
      wallpaperDir = "assets/wallpapers";

      # Specific wallpaper to use as default
      defaultWallpaper = "assets/wallpapers/ryo-night-looking-cam.jpg";
    };

    # Fastfetch color configuration (using stylix base16 slot names)
    # These map to the base16 scheme colors automatically
    fastfetch = {
      # Color names that fastfetch recognizes
      title = "blue"; # Will use base0D (primary blue)
      key = "magenta"; # Will use base0E (purple)
      info = "green"; # Will use base0B (green)
      separator = "cyan"; # Will use base0C (cyan)
    };
  };
}
