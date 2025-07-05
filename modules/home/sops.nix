{config, ...}: {
  # https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/
  sops = {
    age.keyFile = "/home/konan/.config/sops/age/keys.txt"; # must have no password!

    # e.g. how to access the secret on config
    # $(cat ${config.sops.secrets.address.path})

    defaultSopsFile = ./secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    secrets.address = {
      # sopsFile = ./secrets.yml.enc; # optionally define per-secret files
      path = "${config.sops.defaultSymlinkPath}/address";
    };

    secrets.gateway = {
      # sopsFile = ./secrets.yml.enc; # optionally define per-secret files
      path = "${config.sops.defaultSymlinkPath}/gateway";
    };
  };
}
