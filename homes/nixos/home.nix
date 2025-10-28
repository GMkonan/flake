{
  config,
  inputs,
  pkgs,
  ...
}: {
  home.username = "konan";
  home.homeDirectory = "/home/konan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Debug: This will show in the build output
  # warnings = [
  #   "GITHUB_TOKEN length: ${toString (builtins.stringLength secrets.GITHUB_TOKEN)}"
  #   "GITHUB_TOKEN starts with: ${builtins.substring 0 10 secrets.GITHUB_TOKEN}..."
  # ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    ../../modules/home/wm
    ../../modules/home/cli
    ../../modules/home/gui

    ../../modules/home/gnome.nix
    ../../modules/home/gtk.nix
    ../../modules/home/stylix.nix
    ../../nvim
    # ../../quickshell

    inputs.stylix.homeModules.stylix
    inputs.noctalia.homeModules.default
    # inputs.walker.homeManagerModules.default
  ];

  # User environment packages
  home.packages = with pkgs; [
    htop
    btop
    python3
    age
    lsof
    brightnessctl
    mullvad-vpn
    hyprshot
  ];
}
