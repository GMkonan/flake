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

  # User environment packages
  home.packages = with pkgs; [
    # Add more user packages here
    fastfetch
    htop
    btop
    python3
  ];

  programs = {
    bat.enable = true;
  };
}
