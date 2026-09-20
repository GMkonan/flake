{
  host,
  pkgs,
  ...
}: let
  secretsPath = ../../secrets.nix;
  secrets =
    if builtins.pathExists secretsPath
    then import secretsPath
    else {
      address = "0.0.0.0";
      gateway = "0.0.0.0";
    };
in {
  imports = [
    ./hardware.nix
    ./storage.nix
    ./services/dashboard.nix
    ./services/media.nix
    ./services/paperless.nix
    ./services/samba.nix
  ];

  _module.args.serverSecrets = secrets;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  systemd.enableEmergencyMode = false;

  networking = {
    hostName = host.hostName;
    interfaces.enp27s0.ipv4.addresses = [
      {
        address = secrets.address;
        prefixLength = 24;
      }
    ];
    defaultGateway = secrets.gateway;
    nameservers = ["8.8.8.8"];
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Sao_Paulo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services = {
    openssh.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  virtualisation.docker.enable = true;

  users.users.${host.user} = {
    isNormalUser = true;
    description = host.user;
    extraGroups = ["networkmanager" "wheel" "docker" "media"];
    packages = [];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    ntfs3g
    docker
    git
    gcc
    lm_sensors
  ];

  system.stateVersion = host.stateVersion.system;
}
