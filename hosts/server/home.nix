{
  host,
  inputs,
  ...
}: {
  imports = [
    (../../themes + "/${host.theme}.nix")

    inputs.stylix.homeModules.stylix

    ../../modules/home/programs/git
    ../../modules/home/shell
    ../../nvim
  ];

  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
}
