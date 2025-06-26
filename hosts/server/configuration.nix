{pkgs, ...}: let
  secrets = import ../../secrets.nix;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../../nvim/default.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.enableEmergencyMode = false;

  networking.hostName = "kessoku"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.interfaces.enp27s0.ipv4.addresses = [
    {
      address = secrets.address;
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = secrets.gateway;
  networking.nameservers = ["8.8.8.8"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.docker.enable = true;

  users.users.sonarr.extraGroups = ["media"];
  users.users.immich.extraGroups = ["media"];
  users = {
    groups.media = {};

    # defaultUserShell = pkgs.zsh;
    users.chico = {
      isNormalUser = true;
      description = "chico";
      extraGroups = ["networkmanager" "wheel" "docker" "media"];
      # shell = pkgs.zsh;
      packages = with pkgs; [];
    };
  };

  fileSystems."/media/data" = {
    device = "/dev/disk/by-uuid/AECEDEC4CEDE83CD"; # specifying by uuid to ensure we are using the correct HD
    fsType = "ntfs-3g";
    options = ["defaults" "nofail" "uid=1000" "gid=991" "umask=002"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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

  # systemd.tmpfiles.rules = [
  #   "d /media/data/share-data 2770 chico media - -"
  # ];

  services.paperless = {
    enable = true;
    mediaDir = "/home/chico/paperless/data";
    user = "chico";
    # put docs here, they will be added and indexed to paperless and later removed from consumptionDir
    consumptionDir = "/home/chico/paperless/consume";
    consumptionDirIsPublic = true;
    passwordFile = "/home/chico/paperless/password";
    settings.PAPERLESS_OCR_LANGUAGE = "por+eng";
    address = "0.0.0.0";
    port = 28981;
  };
  networking.firewall.allowedTCPPorts = [28981];

  # systemd.services.paperless-scheduler.after = ["var-lib-paperless.mount"];
  # systemd.services.paperless-consumer.after = ["var-lib-paperless.mount"];
  # systemd.services.paperless-web.after = ["var-lib-paperless.mount"];

  services.glances = {
    enable = true;
  };

  services.immich = {
    enable = true;
    host = "${secrets.address}";
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
        "Glances" = [
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
            "Network" = {
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
            "Process" = {
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
        "Media" = [
          {
            "Kyoo" = {
              description = "Best media solution";
              href = "http://${secrets.address}:8901";
              icon = "https://github.com/zoriya/Kyoo/blob/master/icons/icon-256x256.png?raw=true";
              siteMonitor = "http://${secrets.address}:8901";
            };
          }
        ];
      }
      {
        "Arr" = [
          {
            "Prowlarr" = {
              description = "Indexer";
              href = "http://${secrets.address}:9696";
              icon = "prowlarr";
              siteMonitor = "http://${secrets.address}:9696";
            };
          }
          {
            "Sonarr" = {
              description = "TV shows";
              href = "http://${secrets.address}:8989";
              icon = "sonarr";
              siteMonitor = "http://${secrets.address}:8989";
            };
          }
          {
            "Radarr" = {
              description = "Movie collection manager";
              href = "http://${secrets.address}:7878";
              icon = "radarr";
              siteMonitor = "http://${secrets.address}:7878";
            };
          }
          {
            "Bazarr" = {
              description = "Subtitles";
              href = "http://${secrets.address}:6767";
              icon = "bazarr";
              siteMonitor = "http://${secrets.address}:6767";
            };
          }
        ];
      }

      {
        "Downloads" = [
          {
            "Deluge" = {
              description = "Torrent client";
              href = "http://${secrets.address}:8112";
              icon = "deluge";
              siteMonitor = "http://${secrets.address}:8112";
            };
          }
        ];
      }
      {
        "Misc" = [
          {
            "Paperless" = {
              description = "Digital documents";
              href = "http://${secrets.address}:28981";
              icon = "paperless";
              siteMonitor = "http://${secrets.address}:28981";
            };
          }
          {
            "Immich" = {
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    shares = {
      chicodata = {
        path = "/media/data/share-data";
        "read only" = "no";
        browseable = "yes";
        writable = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "chico";
        comment = "chico share data";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
