{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Basic settings
        follow = "keyboard";
        width = 300;
        height = 100;
        origin = "top";
        offset = "10x10";
        notification_limit = 0;

        # Appearance
        transparency = 0;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 1;
        separator_height = 1;
        corner_radius = 8;

        # Text
        font = "monospace 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";

        # Icons
        icon_position = "left";
        min_icon_size = 16;
        max_icon_size = 64;

        # History
        sticky_history = "yes";
        history_length = 20;
      };
    };
  };
}
