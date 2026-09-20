{
  host,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./bootloader.nix
    ../../modules/nixos/core
    ../../modules/nixos/desktop
    ../../modules/nixos/networking
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
    (../../themes + "/${host.theme}.nix")
    inputs.stylix.nixosModules.stylix
    inputs.noctalia-greeter.nixosModules.default
  ];

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

  services.displayManager.noctalia-greeter = {
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

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.settings.Sleep.HibernateDelaySec = "1h";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    # Binary cache for affinity-nix (avoids building patched Wine locally)
    extra-substituters = ["https://cache.forall.systems"];
    extra-trusted-public-keys = [
      "cache.forall.systems:5PmD7QO4MSF8YgyRZtkSGXRDo96H3bybIf2SsQh8ScI="
    ];
  };

  system.stateVersion = host.stateVersion.system;
}
