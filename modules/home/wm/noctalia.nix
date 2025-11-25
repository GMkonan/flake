{...}: {
  programs.noctalia-shell = {
    enable = true;

    # #173688
    # https://docs.noctalia.dev/getting-started/nixos/#config-ref
    settings = {
      general = {
        avatarImage = "~/flake/ryo-2-twitter.jpg";
        lockOnSuspend = true;
        language = "";
      };
      dock = {
        enable = false;
      };
      bar = {
        position = "top";
        backgroundOpacity = 1;
        monitors = [];
        density = "default";
        showCapsule = true;
        floating = false;
        marginVertical = 0.25;
        marginHorizontal = 0.25;
        widgets = {
          left = [
            {
              id = "ControlCenter";
            }
            # {
            #   id = "SystemMonitor";
            # }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              id = "TaskbarGrouped";
            }
          ];
          right = [
            # {
            #   id = "ScreenRecorder";
            # }
            {
              id = "MediaMini";
            }
            {
              id = "KeyboardLayout";
            }
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "wifi";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            # {
            #   id = "Brightness";
            # }
            {
              id = "Clock";
            }
          ];
        };
      };
      location = {
        name = "Vitoria, ES, Brazil";
        weatherEnabled = true;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
      };
      colorSchemes = {
        predefinedScheme = "Tokyo Night";
      };
      wallpaper = {
        enabled = true;
        directory = "~/flake/wallpapers/dark/";
        defaultWallpaper = "../../../wallpapers/dark/ryo-night-looking-cam.jpg";

        # randomEnabled = true;
        # randomIntervalSec = 1200;
      };
    };
  };
}
