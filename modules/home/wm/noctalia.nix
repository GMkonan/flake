{...}: {
  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "compact";
        showCapsule = false;
        outerCorners = false;
        marginVertical = 5;
        marginHorizontal = 5;

        widgets = {
          left = [
            {
              id = "ControlCenter";
              colorizeDistroLogo = false;
              colorizeSystemIcon = "primary";
              customIconPath = "/home/konan/Downloads/my-idle-0-symbolic.svg";
              enableColorization = true;
              icon = "noctalia";
              useDistroLogo = true;
            }
            {
              id = "Workspace";
              characterCount = 2;
              colorizeIcons = true;
              emptyColor = "none";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              fontWeight = "bold";
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.8;
              labelMode = "index";
              occupiedColor = "none";
              pillSize = 0.7;
              showApplications = false;
              showApplicationsHover = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = false;
              unfocusedIconsOpacity = 1;
            }
          ];
          center = [
            {
              id = "plugin:catwalk";
            }
            {
              id = "Clock";
              clockColor = "primary";
              customFont = "";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
          ];
          right = [
            {
              id = "MediaMini";
              compactMode = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              maxWidth = 145;
              panelShowAlbumArt = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "linear";
            }
            {
              id = "Tray";
              drawerEnabled = true;
              blacklist = [];
              chevronColor = "none";
              colorizeIcons = false;
              hidePassive = false;
              pinned = [];
            }
            {
              id = "Volume";
              displayMode = "onhover";
              iconColor = "none";
              middleClickCommand = "pwvucontrol || pavucontrol";
              textColor = "none";
            }
            {
              id = "NotificationHistory";
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
            {
              id = "Battery";
              deviceNativePath = "__default__";
              displayMode = "graphic";
              hideIfIdle = false;
              hideIfNotDetected = true;
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
            }
            {
              id = "plugin:netbird";
            }
            {
              id = "plugin:tailscale";
            }
            {
              id = "plugin:privacy-indicator";
            }
            {
              id = "plugin:keybind-cheatsheet";
            }
          ];
        };
      };

      general = {
        avatarImage = "~/flake/ryo-2-twitter.jpg";
      };

      location = {
        name = "Vitoria, ES, Brazil";
      };

      notifications = {
        density = "compact";
      };

      wallpaper = {
        directory = "/home/konan/Pictures/Wallpapers";
      };

      dock = {
        enabled = false;
      };

      colorSchemes = {
        predefinedScheme = "Nord";
      };
    };
  };
}
