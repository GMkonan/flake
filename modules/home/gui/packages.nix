{pkgs, ...}: {
  home.packages = with pkgs; [
    davinci-resolve
    mpv
    obs-studio
    libreoffice
    shotcut
  ];
}
