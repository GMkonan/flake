{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  # System-level packages - essentials and shared dependencies
  environment.systemPackages = with pkgs; [
    # Essentials (emergency fallback)
    vim
    git
    gcc

    # System services
    docker
    postgresql

    # Wayland/clipboard integration
    wl-clipboard

    # Desktop environment
    xwayland-satellite
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Browsers (system-level)
    inputs.zen.packages.${pkgs.stdenv.hostPlatform.system}.default
    brave

    # Qt dependencies (shared)
    material-symbols
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum

    # Bootstrap
    home-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    material-symbols
    material-icons
    roboto
  ];
}
