{
  host,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos
    (../../themes + "/${host.theme}.nix")
    inputs.stylix.nixosModules.stylix
    inputs.hermes-agent.nixosModules.default
  ];

  services.hermes-agent = {
    enable = true;
    environmentFiles = ["~/.secrets"];
    addToSystemPackages = true;
  };

  networking.hostName = host.hostName;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  programs.xwayland.enable = true;
  programs.nix-ld.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;
  services.upower.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = host.stateVersion.system;
}
