{
  inputs,
  pkgs,
  ...
}: {
  home.username = "chico";
  home.homeDirectory = "/home/chico";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  imports = [
    ../../modules/home/cli
  ];

  home.packages = with pkgs; [
    fastfetch
    htop
    btop
  ];
}
