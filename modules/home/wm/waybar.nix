{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 15;
        spacing = 4;

        modules-left = ["custom/power-button"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["hyprland/language" "group/system" "battery" "clock#date" "clock#time"];

        "custom/power-button" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
        };

        "group/system" = {
          modules = [
            "network"
            "group/volume"
            "bluetooth"
          ];
          orientation = "horizontal";
        };

        "hyprland/language" = {
          format = "⌨ {}";
          format-en = "US";
          # format-<shortcode> should use the short description and not name, which is why we do "pt" instead of "br" which seems more obvious
          # You can check this by chaning layouts while executing waybar on debug mode
          # this could be useful at some point too: https://github.com/Alexays/Waybar/issues/3676
          format-pt = "BR";
          on-click = "hyprctl switchxkblayout current next";
        };

        bluetooth = {
          format = "";
          format-connected = "󰂱";
          format-disabled = "󰂲";
          format-off = "󰂲";
          format-on = "";
          on-click = "blueberry";
          on-click-right = "rfkill toggle bluetooth";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t󰥉{device_battery_percentage}%";
        };

        "group/volume" = {
          drawer = {
            children-class = "volume";
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
          orientation = "horizontal";
        };

        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "{icon}";
          format-icons = {
            default = [
              "󰕿"
              ""
              "󰕾"
            ];
          };
          format-muted = "󰖁";
          on-click = "pavucontrol";
          on-click-right = "pactl set-sink-mute 0 toggle";
          scroll-step = 1;
          tooltip-format = "{desc}\t{icon}{volume}%";
        };

        "pulseaudio/slider" = {
          max = 100;
          min = 0;
          orientation = "horizontal";
        };

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
          format-icons = ["󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"];
        };

        # clock = {
        #   format = "{:%I:%M %p} ";
        #   interval = 1;
        #   tooltip-format = "<tt>{calendar}</tt>";
        #   calendar = {
        #     format = {
        #       today = "<span color='#fAfBfC'><b>{}</b></span>";
        #     };
        #   };
        #   actions = {
        #     on-click-right = "shift_down";
        #     on-click = "shift_up";
        #   };
        # };

        "clock#time" = {
          format = "{:%H:%M}";
          interval = 1;
          tooltip = false;
        };

        # Date module
        "clock#date" = {
          format = "{:%a  %d  %b}";
          interval = 60;
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            format = {
              today = "<span color='#fAfBfC'><b>{}</b></span>";
              months = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#ecc6d9'><b>{}</b></span>";
              days = "<span color='#bfc9db'>{}</span>";
            };
          };
          actions = {
            on-click-right = "shift_down";
            on-click = "shift_up";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        network = {
          format = "{icon}";
          format-disconnected = "󰖪";
          format-ethernet = "󰈀";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-linked = "󰖩";
          format-wifi = "{icon}";
          on-click = "nm-connection-editor";
          on-click-right = "rfkill toggle wifi";
          tooltip = true;
          tooltip-format = "interface:\t{ifname}\n\nconnected to {essid} at {signalStrength}% strength";
          tooltip-format-disconnected = "interface: {ifname}\nconnected to {essid}\nat {signalStrength}% strength";
        };
      };
    };

    style =
      #css
      ''
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
          font-size: 16px;
          min-height: 0;
          margin: 0;
          padding: 0;
        }

        #waybar {
          background: alpha(@crust, 0.2);
          color: @text;
          margin: 2px 5px;
        }

        #system,
        #custom-power-button {
          border-radius: 4px;
          margin: 2px 5px;
          padding: 3px 5px;
          font-size: 14px;
        }

        #battery {
          margin: 2px 5px;
          padding: 3px 5px;
        }

        #language {
          margin: 2px 5px;
          padding: 3px 5px;
        }

        #custom-power-button {
          padding-right: 17px;
          padding-left: 12px;
          color: @red;
        }

        #pulseaudio {
          font-size: 16px;
        }

        #clock.time {
          margin-left: 5px;
          padding: 1px 5px;
          background: @mauve;
          color: @crust;
          font-weight: bold;
          font-size: 18px;
        }

        #clock.date {
          font-weight: bold;
          font-size: 18px;
        }

        #workspaces {
          background-color: @mantle;
          border-radius: 4px;
        }

        #workspaces > button {
          padding: 0px 8px;
          font-weight: 900;
          font-size: 18px;
          border-radius: 0px;
        }

        #workspaces button.active {
          color: @crust;
          background: @lavender
        }

        #workspaces button:hover {
          background-color: @sapphire;
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

        #network {
          margin-right: 15px;
        }

        #pulseaudio {
          margin-right: 15px;
        }

        #pulseaudio-slider {
          border: none;
        }

        #pulseaudio-slider {
          margin-left: 5px;
          margin-right: 5px;
        }

        #pulseaudio-slider slider {
          margin-left: -10px;
          min-width: 10px;
          min-height: 10px;
          background: transparent;
          box-shadow: none;
          padding: 0px;
        }

        #pulseaudio-slider trough {
          min-width: 80px;
          border-radius: 5px;
          background-color: @surface0;
        }

        #pulseaudio-slider highlight {
          border-radius: 5px;
          min-height: 8px;
          background-color: @lavender;
        }

      '';
  };

  home.packages = with pkgs; [
    font-awesome
    jq
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    nerd-fonts.code-new-roman
  ];
}
