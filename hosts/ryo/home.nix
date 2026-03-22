{
  host,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home/themes
  ];

  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # brightnessctl
    hyprshot

    slack
    obsidian
    ticktick
    mpv
    libreoffice
    # figma-linux
    anki
    # davinci-resolve

    inputs.affinity-nix.packages.${pkgs.stdenv.hostPlatform.system}.v3
  ];
}
