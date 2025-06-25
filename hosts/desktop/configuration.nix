{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "bocchi";

  # auto upgrade module
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # garbage collector module
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # NOT A MODULE
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # network
  networking.networkmanager.enable = true;

  # locale / time module
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # experimental
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # hosts desktop, thinkpad
  services.xserver.enable = true;

  # keeb
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # hosts thinkpad?
  services.printing.enable = true;

  # audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
