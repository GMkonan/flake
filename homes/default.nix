{pkgs, ...}: {
  imports = [
    # programs
    ../modules/home/programs/dev
    ../modules/home/programs/ghostty
    ../modules/home/programs/git
    ../modules/home/programs/git/gh.nix
    ../modules/home/programs/packages.nix
    ../modules/home/programs/shell
    ../modules/home/programs/vpn
    ../nvim

    # system
    ../modules/home/system/wm
    ../modules/home/system/noctalia
    ../modules/home/system/idle
    ../modules/home/system/kanshi
    ../modules/home/system/gtk
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
