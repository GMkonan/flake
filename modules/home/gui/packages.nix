{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
    mpv
    libreoffice
    # shotcut
    vial
    bitwarden-desktop
    figma-linux
    vscode
    # code-cursor
    # devpod-desktop
    anki
  ];
}
