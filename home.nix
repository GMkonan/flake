{ config, pkgs, ... }:

{
  home.username = "konan";
  home.homeDirectory = "/home/konan";
  
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  # You can specify packages for your user environment
  # home.packages = with pkgs; [
  #   firefox
  #   btop
  #   # Add more user packages here
  # ];

  # Configure git
  # programs.git = {
  #   enable = true;
  #   userName = "Your Name";
  #   userEmail = "your.email@example.com";
  # };

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
      # Simplified right modules to focus on what's working
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
};  # You can add other program configurations here

wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Your Hyprland settings as before
      monitor = [
        ",preferred,auto,1"
      ];
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };
      
      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };

      exec-once = ["waybar"];
      
      bind = [
        # "ALT, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "ALT, Q, killactive,"
        "ALT SHIFT, E, exit,"
        "ALT, R, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "ALT, left, movefocus, l"
        "ALT, right, movefocus, r"
        "ALT, up, movefocus, u"
        "ALT, down, movefocus, d"

    "ALT, 1, workspace, 1"
    "ALT, 2, workspace, 2"
    "ALT, 3, workspace, 3"
    "ALT, 4, workspace, 4"
    "ALT, 5, workspace, 5"
    "ALT, 6, workspace, 6"
    "ALT, 7, workspace, 7"
    "ALT, 8, workspace, 8"
    "ALT, 9, workspace, 9"
    "ALT, 0, workspace, 10"
    
    # Move active window to workspace using Alt + Shift + [0-9]
    "ALT SHIFT, 1, movetoworkspace, 1"
    "ALT SHIFT, 2, movetoworkspace, 2"
    "ALT SHIFT, 3, movetoworkspace, 3"
    "ALT SHIFT, 4, movetoworkspace, 4"
    "ALT SHIFT, 5, movetoworkspace, 5"
    "ALT SHIFT, 6, movetoworkspace, 6"
    "ALT SHIFT, 7, movetoworkspace, 7"
    "ALT SHIFT, 8, movetoworkspace, 8"
    "ALT SHIFT, 9, movetoworkspace, 9"
    "ALT SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };

  # User environment packages
  home.packages = with pkgs; [
    wofi
    waybar
    font-awesome
    # Add more user packages here
  ];
}
