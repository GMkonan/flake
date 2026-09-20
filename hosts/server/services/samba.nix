{host, ...}: {
  services = {
    samba = {
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

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
