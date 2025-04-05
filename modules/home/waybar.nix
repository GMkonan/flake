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
      * {
        border: none;
        border-radius: 0;
        font-family: "Noto Sans", "Roboto", "Arial", sans-serif;
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(43, 48, 59, 0.9);
        color: #ffffff;
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
