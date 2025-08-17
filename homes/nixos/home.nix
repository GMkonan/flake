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

  imports = [
    ../../modules/home/wm
    ../../modules/home/cli
    ../../modules/home/gui

    ../../modules/home/gnome.nix
    ../../modules/home/gtk.nix
    ../../modules/home/stylix.nix
    ../../modules/home/sops.nix

    inputs.stylix.homeModules.stylix
    inputs.ags.homeManagerModules.default
    inputs.walker.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
  ];

  # User environment packages
  home.packages = with pkgs; [
    htop
    btop
    python3
    age
  ];
}
