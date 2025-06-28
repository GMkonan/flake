{
  pkgs,
  inputs,
  ...
}: let
  overlays = import ../../overlays/default.nix;
in {
  nixpkgs.overlays = [overlays];

  imports = [
    ./hardware.nix

    ../../modules/system
    ../../modules/system/nvidia.nix

    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.stylix.nixosModules.stylix
  ];

  networking.hostName = "bocchi";

  # NOT A MODULE
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # network
  networking.networkmanager.enable = true;

  # hosts desktop, thinkpad
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # keeb
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # hosts thinkpad?
  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
