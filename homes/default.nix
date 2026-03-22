{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # programs
    ../modules/home/programs/dev
    ../modules/home/programs/discord
    ../modules/home/programs/fetch
    ../modules/home/programs/ghostty
    ../modules/home/programs/git
    ../modules/home/programs/git/gh.nix
    ../modules/home/programs/shell
    ../modules/home/programs/spotify
    ../modules/home/programs/vpn
    ../modules/home/programs/password-manager
    ../nvim

    # system
    ../modules/home/system/desktop
    ../modules/home/system/wm
    ../modules/home/system/noctalia
    ../modules/home/system/idle
    ../modules/home/system/kanshi
    ../modules/home/system/gtk

    inputs.stylix.homeModules.stylix
    inputs.noctalia.homeModules.default
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
