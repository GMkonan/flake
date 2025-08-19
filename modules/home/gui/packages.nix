{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
    mpv
    libreoffice
    shotcut
  ];
}
