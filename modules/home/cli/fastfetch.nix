{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
      };

      display = {
        size = {
          binaryPrefix = "si";
        };
        separator = "   ";
      };
      modules = [
        {
          type = "command";
          key = " ";
          text = "echo ' Abandoning your uniqueness is equivalent to dying.'";
        }
        {
          type = "custom";
          format = "┌─────────────────────────────────────────────────┐";
        }
        {
          type = "chassis";
          key = "  󰇺  Chassis";
          format = "{1} {2} {3}";
        }
        {
          type = "os";
          key = "    OS";
          format = "{2}";
          # Colors are now managed by stylix
        }
        {
          type = "packages";
          key = "  󰏗  Packages";
          # Colors are now managed by stylix
        }
        {
          type = "display";
          key = "  󰍹  Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
          # Colors are now managed by stylix
        }
        {
          type = "terminal";
          key = "    Terminal";
          # Colors are now managed by stylix
        }
        {
          type = "wm";
          key = "  󱗃  WM";
          format = "{2}";
          # Colors are now managed by stylix
        }
        {
          type = "custom";
          format = "└─────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "title";
          key = "  ";
          format = "{6} {7} {8}";
        }
        {
          type = "custom";
          format = "┌─────────────────────────────────────────────────┐";
        }
        {
          type = "cpu";
          format = "{1} @ {7}";
          key = "    CPU";
          # Colors are now managed by stylix
        }
        {
          type = "gpu";
          format = "{1} {2}";
          key = "  󰊴  GPU";
          # Colors are now managed by stylix
        }
        {
          type = "gpu";
          format = "{3}";
          key = "    GPU Driver";
          # Colors are now managed by stylix
        }
        {
          type = "memory";
          key = "    Memory ";
          # Colors are now managed by stylix
        }
        {
          type = "disk";
          key = "  󱦟  OS Age ";
          folders = "/";
          format = "{days} days";
          # Colors are now managed by stylix
        }
        {
          type = "uptime";
          key = "  󱫐  Uptime ";
          # Colors are now managed by stylix
        }
        {
          type = "custom";
          format = "└─────────────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
