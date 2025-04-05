{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["clock" "battery"];
        
        battery = {
          format = "{capacity}%";
          format-charging = "{capacity}% (charging)";
          format-alt = "{time}";
          interval = 30;
          states = {
            warning = 30;
            critical = 15;
          };
        };
        
        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
      };
    };
    
    style = ''

      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
        border: none;
        border-radius: 0;
        font-family: "Noto Sans", "Roboto", "Arial", sans-serif;
        font-size: 13px;
        min-height: 0;
      }
      
      #waybar {
        background: @base;
        color: @text;
        margin: 5px 5px;
      }
      
      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
      }
      
      #workspaces button.active {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }
      
      #battery {
        padding: 0 10px;
        margin: 0 5px;
        background-color: #2980b9;
      }
      
      #battery.warning {
        background-color: #f39c12;
      }
      
      #battery.critical {
        background-color: #e74c3c;
      }
      
      #clock {
        padding: 0 10px;
        margin: 0 5px;
        background-color: #27ae60;
      }
    '';
  };

  home.packages = with pkgs; [
    waybar
    font-awesome
  ];
}
