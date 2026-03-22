{
  host,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home/stylix.nix
    ../../modules/home/system/gnome.nix
    ../../modules/home/system/gtk.nix
    ../../modules/home/system/noctalia.nix
    ../../modules/home/themes

    inputs.stylix.homeModules.stylix
    inputs.noctalia.homeModules.default
  ];

  home = {
    homeDirectory = host.homeDirectory;
    stateVersion = host.stateVersion.home;
    username = host.user;
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # brightnessctl
    hyprshot
    inputs.affinity-nix.packages.${pkgs.stdenv.hostPlatform.system}.v3
  ];
}
