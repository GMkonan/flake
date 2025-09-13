{
  pkgs,
  inputs,
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
    zsh
    gcc
    docker
    wl-clipboard
    ticktick
    postgresql
    beamMinimal27Packages.elixir_1_17
    home-manager
    inputs.zen.packages.${pkgs.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # nerd-fonts.commit-mono
  ];
}
