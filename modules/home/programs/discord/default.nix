{
  config,
  inputs,
  ...
}: let
  quickCss = config.theme.active.apps.nixcord.quickCss;
in {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    inherit quickCss;
    config.useQuickCss = quickCss != "";
    vesktop.enable = true;
  };
}
