{pkgs, ...}: {
  home.packages = with pkgs; [
    # bitwarden-desktop # FIXME: temporarily removed due to upstream nixpkgs build failure
    _1password-cli
    _1password-gui
  ];
}
