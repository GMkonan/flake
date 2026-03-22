{
  host,
  inputs,
  ...
}: {
  imports = [
    (../../themes + "/${host.theme}.nix")
    inputs.stylix.homeModules.stylix
  ];

  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;
  };

  programs.home-manager.enable = true;
}
