{pkgs, ...}: {
  imports = [
    # Programs
    ../modules/home/programs/git
    ../modules/home/programs/git/gh.nix
    ../modules/home/programs/shell
    ../nvim

    # System
    ../modules/home/system/wm
    ../modules/home/system/noctalia
    ../modules/home/system/idle
    ../modules/home/system/kanshi
    ../modules/home/system/gtk
  ];

  fonts.fontconfig.enable = true;
}
