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
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.enableEmergencyMode = false;

  networking.hostName = host.hostName;
  networking.interfaces.enp27s0.ipv4.addresses = [
    {
      address = secrets.address;
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = secrets.gateway;
  networking.nameservers = ["8.8.8.8"];
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.docker.enable = true;

  users.groups.media = {};
  users.users.sonarr.extraGroups = ["media"];
  users.users.immich.extraGroups = ["media"];
  users.users.${host.user} = {
    isNormalUser = true;
    description = host.user;
    extraGroups = ["networkmanager" "wheel" "docker" "media"];
    packages = with pkgs; [];
  };

  fileSystems."/media/data" = {
    device = "/dev/disk/by-uuid/AECEDEC4CEDE83CD";
    fsType = "ntfs-3g";
    options = ["defaults" "nofail" "uid=1000" "gid=991" "umask=002"];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    ntfs3g
    docker
    git
    gcc
    lm_sensors
  ];

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.deluge = {
    enable = true;
    web.enable = true;
    web.openFirewall = true;
    openFirewall = true;
    group = "media";
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.paperless = {
    enable = true;
    mediaDir = "${host.homeDirectory}/paperless/data";
    user = host.user;
    consumptionDir = "${host.homeDirectory}/paperless/consume";
    consumptionDirIsPublic = true;
    passwordFile = "${host.homeDirectory}/paperless/password";
    settings.PAPERLESS_OCR_LANGUAGE = "por+eng";
    address = "0.0.0.0";
    port = 28981;
  };
  networking.firewall.allowedTCPPorts = [28981];

  services.glances.enable = true;

  services.immich = {
    enable = true;
    host = secrets.address;
    openFirewall = true;
    mediaLocation = "/media/data/immich/immich/";
    group = "media";
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "127.0.0.1:8082,localhost:8082,${secrets.address}:8082";
    customCSS = ''
      body, html {
        font-family: SF Pro Display, Helvetica, Arial, sans-serif !important;
      }
      .font-medium {
        font-weight: 700 !important;
      }
      .font-light {
        font-weight: 500 !important;
      }
      .font-thin {
        font-weight: 400 !important;
      }
    '';
    settings = {
      title = "Chico's Homepage";
      layout = [
        {
          Glances = {
            header = false;
            style = "row";
            columns = 4;
          };
        }
        {
          Media = {
            header = true;
            style = "row";
            columns = 4;
          };
        }
        {
          Arr = {
            header = true;
            style = "row";
            columns = 4;
          };
        }
        {
          Downloads = {
            header = true;
            style = "row";
            columns = 4;
          };
        }
        {
          Misc = {
            header = true;
            style = "row";
            columns = 4;
          };
        }
      ];
    };
    services = [
      {
        Glances = [
          {
            "CPU/RAM Usage" = {
              widget = {
                type = "glances";
                url = "http://localhost:61208";
                metric = "info";
                chart = true;
                version = 4;
              };
            };
          }
          {
            "CPU Temp" = {
              widget = {
                type = "glances";
                url = "http://localhost:61208";
                metric = "sensor:Package id 0";
                chart = true;
                version = 4;
              };
            };
          }
          {
            Network = {
              widget = {
                type = "glances";
                url = "http://localhost:61208";
                metric = "network:enp27s0";
                chart = true;
                version = 4;
              };
            };
          }
          {
            Process = {
              widget = {
                type = "glances";
                url = "http://localhost:61208";
                metric = "process";
                chart = true;
                version = 4;
              };
            };
          }
        ];
      }
      {
        Media = [
          {
            Kyoo = {
              description = "Best media solution";
              href = "http://${secrets.address}:8901";
              icon = "https://github.com/zoriya/Kyoo/blob/master/icons/icon-256x256.png?raw=true";
              siteMonitor = "http://${secrets.address}:8901";
            };
          }
        ];
      }
      {
        Arr = [
          {
            Prowlarr = {
              description = "Indexer";
              href = "http://${secrets.address}:9696";
              icon = "prowlarr";
              siteMonitor = "http://${secrets.address}:9696";
            };
          }
          {
            Sonarr = {
              description = "TV shows";
              href = "http://${secrets.address}:8989";
              icon = "sonarr";
              siteMonitor = "http://${secrets.address}:8989";
            };
          }
          {
            Radarr = {
              description = "Movie collection manager";
              href = "http://${secrets.address}:7878";
              icon = "radarr";
              siteMonitor = "http://${secrets.address}:7878";
            };
          }
          {
            Bazarr = {
              description = "Subtitles";
              href = "http://${secrets.address}:6767";
              icon = "bazarr";
              siteMonitor = "http://${secrets.address}:6767";
            };
          }
        ];
      }
      {
        Downloads = [
          {
            Deluge = {
              description = "Torrent client";
              href = "http://${secrets.address}:8112";
              icon = "deluge";
              siteMonitor = "http://${secrets.address}:8112";
            };
          }
        ];
      }
      {
        Misc = [
          {
            Paperless = {
              description = "Digital documents";
              href = "http://${secrets.address}:28981";
              icon = "paperless";
              siteMonitor = "http://${secrets.address}:28981";
            };
          }
          {
            Immich = {
              description = "Photos";
              href = "http://${secrets.address}:2283";
              icon = "immich";
              siteMonitor = "http://${secrets.address}:2283";
            };
          }
        ];
      }
    ];
  };

  services.openssh.enable = true;

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global.security = "user";

      chicodata = {
        path = "/media/data/share-data";
        "read only" = "no";
        browseable = "yes";
        writable = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = host.user;
        comment = "${host.user} share data";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.stateVersion = host.stateVersion.system;
}
