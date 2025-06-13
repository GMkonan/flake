{pkgs, ...}: {
  # For now I will still manage zsh myself
  # programs.zsh = {
  #   enable = true;
  # };

  home.packages = with pkgs; [
    zsh
    oh-my-posh
    zoxide
    lsd
    fzf
    fd
    ripgrep
    graphite-cli
  ];
}
