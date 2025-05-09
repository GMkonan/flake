{
  pkgs,
  zen,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    ghostty
    zsh
    gcc
    docker
    wl-clipboard
    ticktick
    beamMinimal27Packages.elixir_1_17
    zen.packages.${pkgs.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # nerd-fonts.commit-mono
  ];
}
