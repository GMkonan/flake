{pkgs, ...}: {
  home.username = "konan";
  home.homeDirectory = "/home/konan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  imports = [
    ./modules/home/hyprpaper.nix
    ./modules/home/waybar.nix
    ./modules/home/hyprland.nix
    ./modules/home/wofi.nix
    ./modules/home/gtk.nix
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
    bat
    wofi
    dunst
  ];

  programs = {
    bat.enable = true;
  };
}
