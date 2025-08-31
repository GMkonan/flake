{
  config,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        grace = 3;
        ignore_empty_input = true;
        immediate_render = true;
      };

      background = {
        monitor = "";
        path = "${config.home.homeDirectory}/flake/wallpapers/dark/night-girl-city-sky.jpeg";
        # path = "/home/${user}/.cache/current-wallpaper";
      };

      input-field = {
        monitor = "";
        size = "250, 50";
        outline_thickness = 1;
        dots_size = 0.27; # Scale of input field height
        dots_spacing = 0.15; # Scale of dots' absolute size
        dots_center = true;
        # check_color = "rgb(200, 200, 200)";
        position = "0, 00";
        fade_on_empty = true;
        placeholder_text = "<i>Password</i>";
        hide_input = false;
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b><big> $(${pkgs.coreutils}/bin/date +"%H:%M") </big></b>"'';

          font_size = 64;
          font_family = "monospace";

          position = "0, -50";
          halign = "center";
          valign = "top";
        }

        {
          monitor = "";
          text = ''cmd[update:18000000] echo "<b> "$(${pkgs.coreutils}/bin/date +'%A, %-d %B %Y')" </b>"'';

          font_size = 24;
          font_family = "monospace";

          position = "0, -150";
          halign = "center";
          valign = "top";
        }

        {
          monitor = "";
          text = "Welcome Back $USER";

          font_size = 24;
          font_family = "monospace";

          position = "0, 70";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
