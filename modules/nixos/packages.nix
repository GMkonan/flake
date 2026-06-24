{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Essentials (emergency fallback)
    vim
    git
    gcc

    # Wayland/clipboard integration
    wl-clipboard

    # Desktop environment
    xwayland-satellite
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Browsers (system-level)
    inputs.zen.packages.${pkgs.stdenv.hostPlatform.system}.default
    brave

    material-symbols

    home-manager
  ];
}
