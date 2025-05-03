{pkgs, ...}: {
  home.username = "konan";
  home.homeDirectory = "/home/konan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  imports = [
    ./modules/home/wm/hyprpaper.nix
    ./modules/home/wm/waybar.nix
    ./modules/home/wm/hyprland.nix
    ./modules/home/wm/wofi.nix
    ./modules/home/gtk.nix
    ./modules/home/wm/dunst.nix
    ./modules/home/wm/hyprlock.nix
    ./modules/home/wm/wlogout.nix
    ./modules/home/wm/ags.nix

    # ./modules/home/gnome.nix
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
  ];

  programs = {
    bat.enable = true;
  };
}
