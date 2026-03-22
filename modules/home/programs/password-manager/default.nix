{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-desktop
    _1password-cli
    _1password-gui
  ];
}
