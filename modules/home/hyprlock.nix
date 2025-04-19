{
  config,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;

    catppuccin.enable = false;

    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        grace = 5;
        no_fade_in = false;
      };

      background = [
        {
          path = "${config.home.homeDirectory}/flake/wallpapers/girl-on-balcony.png";
        }
      ];

      input-field = [
        {
          size = {
            width = 300;
            height = 50;
          };
          outline_thickness = 1;
          dots_size = 0.27; # Scale of input field height
          dots_spacing = 0.15; # Scale of dots' absolute size
          dots_center = false;
          outer_color = "rgb(151515)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          placeholder_text = "<i>Password</i>";
          hide_input = false;
          position = {
            x = 0;
            y = -90;
          };
          halign = "center";
          valign = "center";
        }
      ];

      labels = [
        {
          # Clock
          text = "$TIME";
          color = "rgb(200, 200, 200)";
          font_size = 50;
          font_family = "JetBrains Mono Nerd Font";
          position = {
            x = 0;
            y = 80;
          };
          halign = "center";
          valign = "center";
        }
        {
          # Welcome text
          text = "Welcome back, $USER!";
          color = "rgb(200, 200, 200)";
          font_size = 20;
          font_family = "JetBrains Mono Nerd Font";
          position = {
            x = 0;
            y = 0;
          };
          halign = "center";
          valign = "center";
        }
        {
          # Lock icon
          text = "󰌾";
          color = "rgb(200, 200, 200)";
          font_size = 21;
          font_family = "JetBrains Mono Nerd Font";
          position = {
            x = 0;
            y = -160;
          };
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";

        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "${pkgs.procps}/bin/pidof hyprlock && ${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
