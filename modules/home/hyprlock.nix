{
  config,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    general = {
      disable_loading_bar = false;
      hide_cursor = true;
      grace = 5;
      no_fade_in = false;
    };

    background = [
      {
        path = "screenshot"; # Screenshot current desktop
        # path = "${config.home.homeDirectory}/path/to/your/wallpaper.png"; # Or use a static wallpaper
        blur_size = 4;
        blur_passes = 3;
        noise = 0.0117;
        contrast = 0.8917;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }
    ];

    input-field = [
      {
        size = {
          width = 300;
          height = 50;
        };
        outline_thickness = 3;
        dots_size = 0.33; # Scale of input field height
        dots_spacing = 0.15; # Scale of dots' absolute size
        dots_center = false;
        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";
        fade_on_empty = true;
        placeholder_text = "<i>Input Password...</i>";
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

  # Make sure the font is available
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
