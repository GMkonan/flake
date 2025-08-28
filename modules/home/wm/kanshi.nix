# {
#   services.kanshi = {
#     enable = true;
#     systemdTarget = "hyprland-session.target";
#     settings = [
#       {
#         profile.name = "docked";
#         profile.outputs = [
#           {
#             criteria = "eDP-1";
#             status = "disable";
#           }
#           {
#             criteria = "Samsung Electric Company LU28R55 HX5W500759";
#             # position = "1500,0";
#             position = "0,0";
#             scale = 2.0;
#           }
#           # {
#           #   criteria = "*";
#           #   position = "0,0";
#           #   scale = 1.0;
#           # }
#         ];
#       }
#       {
#         profile.name = "undocked";
#         profile.outputs = [
#           {
#             status = "enable";
#             criteria = "eDP-1";
#             scale = 1.5;
#           }
#         ];
#       }
#     ];
#   };
# }
# {
#   services.kanshi = {
#     enable = true;
#     settings = [
#       {
#         profile.name = "undocked";
#         profile.outputs = [
#           {
#             criteria = "eDP-1";
#             scale = 1.5;
#           }
#         ];
#       }
#       {
#         profile.name = "docked";
#         profile.outputs = [
#           {
#             criteria = "Samsung Electric Company LU28R55 HX5W500759";
#             status = "enable";
#             scale = 2.0;
#           }
#           {
#             criteria = "eDP-1";
#             status = "disable";
#           }
#         ];
#       }
#     ];
#     # Post about kanshi systemd user service not starting with sway:
#     # https://discourse.nixos.org/t/starting-kanshi-via-systemd-user-swaywm/27960/2
#     # The posted solution is to set systemdTarget to an empty string.
#     systemdTarget = "graphical-session.target";
#   };
# }
{
  services.shikane = {
    enable = false;
    settings = {
      profile = [
        {
          name = "docked";
          output = [
            {
              match = "eDP-1";
              enable = false;
            }
            {
              search = "/.*";
              enable = true;
              scale = 2;
              # mode = "3840x1600@59.99300";
            }
          ];
        }
        {
          name = "undocked";
          output = [
            {
              match = "eDP-1";
              enable = true;
              scale = 1.5;
              # mode = "1920x1200@60.00Hz";
            }
          ];
        }
      ];
    };
  };
}
