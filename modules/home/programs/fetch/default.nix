{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = config.theme.active;
  logoConfig = {
    source = ../../../../assets/fetch/logo.txt;
    type = "file-raw";
    padding = {
      left = 1;
      right = 3;
      top = 0;
    };
  };

  cleanAttrs = attrs: lib.filterAttrs (_: value: value != null) attrs;

  fastfetchConfig = {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";
    display = cleanAttrs {
      color = {
        keys = theme.colors.primary;
        output = theme.colors.text;
        separator = theme.colors.info;
        title = theme.colors.secondary;
      };
    };
    logo = cleanAttrs {
      source = toString logoConfig.source;
      type = logoConfig.type;
      padding = logoConfig.padding or null;
      width = logoConfig.width or null;
      height = logoConfig.height or null;
      preserveAspectRatio = logoConfig.preserveAspectRatio or null;
      printRemaining = logoConfig.printRemaining or null;
      position = logoConfig.position or null;
    };
    modules = [
      {
        type = "title";
        key = " ";
        keyIcon = "";
        color = {
          user = theme.colors.primary;
          at = theme.colors.textMuted;
          host = theme.colors.secondary;
        };
      }
      {
        type = "separator";
        string = "────────────────";
        outputColor = theme.colors.surfaceVariant;
      }
      {
        type = "os";
        key = "os";
        keyIcon = "󰣇";
      }
      {
        type = "host";
        key = "host";
        keyIcon = "󰌢";
      }
      {
        type = "kernel";
        key = "kernel";
        keyIcon = "";
      }
      {
        type = "uptime";
        key = "uptime";
        keyIcon = "󰅐";
      }
      {
        type = "packages";
        key = "pkgs";
        keyIcon = "󰏗";
        combined = false;
        disabled = ["winget"];
      }
      {
        type = "shell";
        key = "shell";
        keyIcon = "";
      }
      {
        type = "wm";
        key = "wm";
        keyIcon = "";
        detectPlugin = true;
      }
      {
        type = "terminal";
        key = "term";
        keyIcon = "";
      }
      {
        type = "terminalfont";
        key = "font";
        keyIcon = "";
      }
      "break"
      {
        type = "cpu";
        key = "cpu";
        keyIcon = "󰍛";
        temp = false;
        showPeCoreCount = false;
      }
      {
        type = "gpu";
        key = "gpu";
        keyIcon = "󰢮";
        detectionMethod = "pci";
        driverSpecific = false;
        hideType = "integrated";
        percent = {
          green = 50;
          type = 0;
          yellow = 80;
        };
        temp = false;
      }
      {
        type = "memory";
        key = "memory";
        keyIcon = "";
        percent = {
          green = 50;
          type = 0;
          yellow = 80;
        };
      }
      {
        type = "disk";
        folders = "/";
        hideFolders = "/efi:/boot:/nix/store";
        hideFS = "tmpfs";
        key = "disk";
        keyIcon = "󰋊";
        percent = {
          green = 50;
          type = 0;
          yellow = 80;
        };
        showExternal = false;
        showHidden = false;
        showReadOnly = false;
        showRegular = true;
        showSubvolumes = false;
        showUnknown = false;
        useAvailable = false;
      }
      {
        type = "battery";
        key = "battery";
        keyIcon = "󰁹";
        percent = {
          green = 50;
          type = 0;
          yellow = 20;
        };
        temp = false;
      }
      "break"
      {
        type = "colors";
        key = " ";
        keyIcon = "";
        paddingLeft = 1;
        symbol = "circle";
        block = {
          range = [0 7];
          width = 2;
        };
      }
    ];
  };
in {
  home.packages = [pkgs.fastfetch];

  xdg.configFile."fastfetch/config.jsonc" = {
    text = builtins.toJSON fastfetchConfig;
  };
}
