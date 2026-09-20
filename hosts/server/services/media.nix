{serverSecrets, ...}: {
  services = {
    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    deluge = {
      enable = true;
      web.enable = true;
      web.openFirewall = true;
      openFirewall = true;
      group = "media";
    };

    bazarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    immich = {
      enable = true;
      host = serverSecrets.address;
      openFirewall = true;
      mediaLocation = "/media/data/immich/immich/";
      group = "media";
    };
  };
}
