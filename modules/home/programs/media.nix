{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    ytmdesktop
  ];
}
