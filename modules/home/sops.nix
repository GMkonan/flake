{...}: {
  # https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/
  sops = {
    age.keyFile = "/home/konan/.config/sops/age/keys.txt";

    # e.g. how to access the secret on config
    # $(cat ${config.sops.secrets.address.path})

    defaultSopsFile = ../../secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    secrets.address = {
      sopsFile = ../../secrets.yaml;
    };

    secrets.gateway = {
      sopsFile = ../../secrets.yaml;
    };

    secrets.github_token = {
      sopsFile = ../../secrets.yaml;
    };

    secrets.anthropic_api_key = {
      sopsFile = ../../secrets.yaml;
    };
  };
}
