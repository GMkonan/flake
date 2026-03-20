{
  config,
  inputs,
  pkgs,
  ...
}: let
  overlays = import ../../overlays/default.nix {inherit (inputs) nixpkgs-pinned;};
in {
  home.username = "konan";
  home.homeDirectory = "/home/konan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [overlays];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    ../../modules/home/themes
    ../../modules/home/wm
    ../../modules/home/cli
    ../../modules/home/gui
    ../../modules/home/dictation-remote.nix

    ../../modules/home/gnome.nix
    ../../modules/home/gtk.nix
    ../../modules/home/stylix.nix
    ../../nvim

    inputs.stylix.homeModules.stylix
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    htop
    btop
    python3
    age
    lsof
    brightnessctl
    mullvad-vpn
    netbird
    hyprshot
    devcontainer
    inputs.affinity-nix.packages.${pkgs.stdenv.hostPlatform.system}.v3
  ];
}
