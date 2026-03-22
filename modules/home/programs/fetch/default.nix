{
  config,
  lib,
  pkgs,
  ...
}: let
  fetchConfig = config.theme.active.apps.fetch;
  fetchName = fetchConfig.package or config.theme.active.ui.fetch or "none";
  fetchPackages = {
    fastfetch = pkgs.fastfetch;
    nerdfetch = pkgs.nerdfetch;
    neofetch = pkgs.fastfetch;
    pfetch = pkgs.pfetch-rs;
  };
in {
  home.packages = lib.optional (builtins.hasAttr fetchName fetchPackages) fetchPackages.${fetchName};

  xdg.configFile."fastfetch/config.jsonc" = lib.mkIf (fetchName == "fastfetch") {
    text = builtins.toJSON {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";
      display.color = fetchConfig.display;
      logo = {
        source = toString fetchConfig.logo.source;
        type = fetchConfig.logo.type;
        padding = fetchConfig.logo.padding;
      };
    };
  };
}
