{...}: {
  programs.noctalia-shell = {
    enable = true;

    # https://docs.noctalia.dev/getting-started/nixos/#config-ref
    settings = {
      general = {
        avatarImage = "~/flake/ryo.jpg";
        lockOnSuspend = true;
        language = "";
      };
      location = {
        name = "Vitoria, ES, Brazil";
        weatherEnabled = true;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
      };
      colorSchemes = {
        predefinedScheme = "Catppuccin";
      };
      wallpaper = {
        enabled = true;
        directory = "~/flake/wallpapers/dark/";
        defaultWallpaper = "~/flake/wallpapers/dark/moonlit.png";
        randomEnabled = true;
        randomIntervalSec = 600;
      };
    };
  };
}
