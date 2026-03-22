{pkgs, ...}: {
  imports = [
    # Programs
    ../modules/home/programs/git
    ../modules/home/programs/git/gh.nix
    ../modules/home/programs/shell
    ../nvim
  ];

  fonts.fontconfig.enable = true;
}
