{...}: {
  programs.noctalia-shell = {
    enable = true;

    # https://docs.noctalia.dev/getting-started/nixos/#config-ref
    settings = {
      general = {
        avatarImage = "../../../ryo.jpg";
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
        directory = "../../../wallpapers/dark";
        randomEnabled = true;
        randomIntervalSec = 600;
      };
    };
  };
}
