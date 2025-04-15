{pkgs, ...}: let
  catppuccin-wofi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "wofi";
    rev = "4ee6dfa37af1a29d8ad1bbce97f5add31848aeda"; # Use the latest commit hash
    sha256 = "sha256-zgQ9n9e8zCAgP2P2pEGK2I35k/K+R9msNGV+D5ZNUoI="; # Update this hash
  };

  flavor = "mocha";
in {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {
      width = 500;
      height = 300;
      mode = "drun";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      orientation = "vertical";
      columns = 1;
    };
  };

  home.file.".config/wofi/style.css".source = "${catppuccin-wofi}/${flavor}.css";
}
