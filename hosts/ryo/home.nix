{
  host,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    (../../themes + "/${host.theme}.nix")

    inputs.stylix.homeModules.stylix
    inputs.noctalia.homeModules.default

    ../../modules/home/desktop/gtk.nix
    ../../modules/home/desktop/kanshi.nix
    ../../modules/home/desktop/keyring.nix
    ../../modules/home/desktop/nautilus.nix
    ../../modules/home/desktop/niri.nix
    ../../modules/home/desktop/noctalia.nix

    ../../modules/home/programs/calibre.nix
    ../../modules/home/programs/communication.nix
    ../../modules/home/programs/creative
    ../../modules/home/programs/development
    ../../modules/home/programs/discord
    ../../modules/home/programs/fetch
    ../../modules/home/programs/ghostty.nix
    ../../modules/home/programs/git
    ../../modules/home/programs/media.nix
    ../../modules/home/programs/bitwarden.nix
    ../../modules/home/programs/productivity.nix
    ../../modules/home/programs/spotify
    ../../modules/home/programs/vpn.nix
    ../../modules/home/shell
    ../../nvim
  ];

  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;

    packages = [pkgs.hyprshot];
    sessionVariables.EDITOR = "nvim";
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  stylix.targets = {
    spicetify.enable = false;
    vscode.enable = false;
  };
}
