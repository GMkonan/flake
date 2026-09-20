{serverSecrets, ...}: {
  services = {
    glances.enable = true;

    homepage-dashboard = {
      enable = true;
      openFirewall = true;
      allowedHosts = "127.0.0.1:8082,localhost:8082,${serverSecrets.address}:8082";
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
                href = "http://${serverSecrets.address}:8901";
                icon = "https://github.com/zoriya/Kyoo/blob/master/icons/icon-256x256.png?raw=true";
                siteMonitor = "http://${serverSecrets.address}:8901";
              };
            }
          ];
        }
        {
          Arr = [
            {
              Prowlarr = {
                description = "Indexer";
                href = "http://${serverSecrets.address}:9696";
                icon = "prowlarr";
                siteMonitor = "http://${serverSecrets.address}:9696";
              };
            }
            {
              Sonarr = {
                description = "TV shows";
                href = "http://${serverSecrets.address}:8989";
                icon = "sonarr";
                siteMonitor = "http://${serverSecrets.address}:8989";
              };
            }
            {
              Radarr = {
                description = "Movie collection manager";
                href = "http://${serverSecrets.address}:7878";
                icon = "radarr";
                siteMonitor = "http://${serverSecrets.address}:7878";
              };
            }
            {
              Bazarr = {
                description = "Subtitles";
                href = "http://${serverSecrets.address}:6767";
                icon = "bazarr";
                siteMonitor = "http://${serverSecrets.address}:6767";
              };
            }
          ];
        }
        {
          Downloads = [
            {
              Deluge = {
                description = "Torrent client";
                href = "http://${serverSecrets.address}:8112";
                icon = "deluge";
                siteMonitor = "http://${serverSecrets.address}:8112";
              };
            }
          ];
        }
        {
          Misc = [
            {
              Paperless = {
                description = "Digital documents";
                href = "http://${serverSecrets.address}:28981";
                icon = "paperless";
                siteMonitor = "http://${serverSecrets.address}:28981";
              };
            }
            {
              Immich = {
                description = "Photos";
                href = "http://${serverSecrets.address}:2283";
                icon = "immich";
                siteMonitor = "http://${serverSecrets.address}:2283";
              };
            }
          ];
        }
      ];
    };
  };
}
