{host, ...}: {
  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;
  };

  programs.home-manager.enable = true;
}
