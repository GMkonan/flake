{inputs, ...}: let
  overlays = import ../../overlays/default.nix;
in {
  nixpkgs.overlays = [overlays];

  imports = [
    ./hardware.nix

    ../../modules/system

    inputs.stylix.nixosModules.stylix
  ];

  networking.hostName = "bonfire";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
