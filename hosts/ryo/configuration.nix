{inputs, ...}: let
  overlays = import ../../overlays/default.nix {inherit (inputs) nixpkgs-pinned;};
in {
  nixpkgs.overlays = [overlays];

  imports = [
    ./hardware.nix

    ../../modules/system

    inputs.stylix.nixosModules.stylix
  ];

  networking.hostName = "ryo";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  programs.xwayland.enable = true;
  # services.logind = {
  #   lidSwitch = "ignore";
  #   lidSwitchDocked = "ignore";
  # };

  programs.nix-ld.enable = true;

  # Tailscale VPN
  services.tailscale.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };

  services.power-profiles-daemon.enable = true;

  services.upower.enable = true;

  # services.blueman.enable = true;

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
