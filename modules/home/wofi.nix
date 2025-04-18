{pkgs, ...}: {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {
      # Basic settings as above
      width = 700;
      height = 300;
      mode = "drun";
      allow_images = true;
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      orientation = "vertical";
      columns = 1;
    };

    # Catppuccin styling (Mocha flavor example)
    style = ''
      /* Catppuccin Mocha Theme */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 14px;
      }

      window {
        margin: 0px;
        padding: 10px;
        border: 1px solid @lavender;
        border-radius: 15px;
        background-color: @base;
        animation: slideIn 0.2s ease-in-out both;
      }

      #inner-box {
        margin: 5px;
        padding: 3px;
        border: none;
        background-color: @base;
        border-radius: 15px;
      }

      #outer-box {
        margin: 5px;
        padding: 3px;
        border: none;
        background-color: @base;
        border-radius: 15px;
      }

      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
      }

      #input {
        margin: 5px;
        padding: 3px;
        border: none;
        color: @text;
        background-color: @surface0;
        border-radius: 10px;
      }

      #text {
        margin: 5px;
        padding: 3px;
        border: none;
        color: @text;
      }

      #entry {
        margin: 5px;
        padding: 3px;
        border-radius: 10px;
        background-color: transparent;
      }

      #entry:selected {
        background-color: @surface0;
        border: none;
      }

      #text:selected {
        color: @mauve;
      }
    '';
  };
}
