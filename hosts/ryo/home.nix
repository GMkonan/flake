{
  host,
  pkgs,
  ...
}: {
  imports = [
    (../../themes + "/${host.theme}.nix")
  ];

  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;
  };

  programs.home-manager.enable = true;

  stylix.targets.spicetify.enable = false;
  stylix.targets.vscode.enable = false;

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
  ];
}
