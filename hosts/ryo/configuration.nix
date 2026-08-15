{
  host,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/nixos
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
    (../../themes + "/${host.theme}.nix")
    inputs.stylix.nixosModules.stylix
    inputs.noctalia-greeter.nixosModules.default
    # inputs.hermes-agent.nixosModules.default  # disabled: upstream hash mismatch
  ];

  # services.hermes-agent = {
  #   enable = true;
  #   environmentFiles = ["~/.secrets"];
  #   addToSystemPackages = true;
  # };

  networking.hostName = host.hostName;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.networkmanager.enable = true;
  # Disable Wi-Fi power saving so large LAN transfers (e.g. LocalSend)
  # don't stall or cancel mid-file.
  networking.networkmanager.wifi.powersave = false;
  # Belt-and-suspenders: keep docker/tailscale bridges from replying to
  # LocalSend's multicast discovery (UDP 53317), so discovery resolves
  # to the real Wi-Fi interface.
  networking.firewall.extraCommands = ''
    iptables -I INPUT -i br-+ -p udp --dport 53317 -j DROP
  '';

  services.xserver.enable = true;
  services.desktopManager.gnome.enable = false;
  services.displayManager.gdm.enable = false;

  programs.noctalia-greeter = {
    enable = true;
    greeter-args = "--session niri";
    settings = {
      keyboard.layout = "us";
    };
  };

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

  services.logind.settings.Login.HandleLidSwitch = "lock";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = host.stateVersion.system;
}
