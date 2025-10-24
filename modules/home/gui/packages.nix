{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
    mpv
    libreoffice
    # shotcut
    vial
    bitwarden
    figma-linux
    vscode
    # code-cursor
    # devpod-desktop
  ];
}
