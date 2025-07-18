{
  inputs,
  pkgs,
  ...
}: {
  home.username = "konan";
  home.homeDirectory = "/home/konan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  imports = [
    ./modules/home/wm
    ./modules/home/cli
    ./modules/home/gui

    ./modules/home/gnome.nix
    ./modules/home/gtk.nix
    ./modules/home/stylix.nix
  ];

  # User environment packages
  home.packages = with pkgs; [
    fastfetch
    htop
    btop
    python3
  ];
}
