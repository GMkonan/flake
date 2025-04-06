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
        modules-right = ["network" "clock" "battery"];

        battery = {
            interval = 30;
            states = {
                good = 95;
                warning = 30;
                critical = 20;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}% 󰂄 ";
            format-alt = "{time} {icon}";
            format-icons = [ "󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
        };

        clock = {
            format = "{:%I:%M %p} ";
            interval = 1;
            tooltip-format = "<tt>{calendar}</tt>";
            calendar = {
                format = {
                    today = "<span color='#fAfBfC'><b>{}</b></span>";
                };
            };
            actions = {
                on-click-right = "shift_down";
                on-click = "shift_up";
            };
        };

        network = {
            format-wifi = "";
            format-ethernet = "";
            format-disconnected = "";
            tooltip-format-disconnected = "Error";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} 🖧 ";
            # on-click = "kitty nmtui";
        };

    # clock = {
    #     # timezone = "American/Dubai";
    #     tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    #     format-alt = " {:%d/%m/%Y}";
    #     format = " {:%H:%M}";
    # };

        # clock = {
        #   format = "{:%H:%M}";
        #   tooltip-format = "{:%Y-%m-%d | %H:%M}";
        # };
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
        font-family: "Font Awesome 5 Free", "Noto Sans", "Roboto", "Arial", sans-serif;
        font-size: 13px;
        min-height: 0;
      }
      
      #waybar {
        background: @base;
        color: @text;
        margin: 5px 5px;
      }

#network,
#clock,
#battery {
  background-color: @surface0;
  padding: 0.5rem 1rem;
  margin: 5px 0;
}

#network {
  color: @maroon;
  border-radius: 0px 1rem 1rem 0px;
  margin-right: 1rem;
}

#clock {
  color: @blue;
  border-radius: 0px 1rem 1rem 0px;
  margin-right: 1rem;
}

 #workspaces {
  border-radius: 1rem;
  margin: 5px;
  background-color: @surface0;
  margin-left: 1rem;
}

#workspaces button {
  color: @lavender;
  border-radius: 1rem;
  padding: 0.4rem;
}

#workspaces button.active {
  color: @sky;
  border-radius: 1rem;
}

#workspaces button:hover {
  color: @sapphire;
  border-radius: 1rem;
}      

#battery {
        color: @green;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

    '';
  };

  home.packages = with pkgs; [
    waybar
    font-awesome
    nerd-fonts.code-new-roman
  ];
}
