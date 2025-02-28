{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
  };


  virtualisation.docker.enable = true;

}
