{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
    mpv
    libreoffice
    shotcut
    devpod-desktop
    qmk
    vial
    bitwarden
    # code-cursor
  ];
}
