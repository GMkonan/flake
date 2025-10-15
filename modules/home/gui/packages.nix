{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
    mpv
    libreoffice
    shotcut
    qmk
    vial
    bitwarden
    figma-linux
    # code-cursor
  ];
}
