{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/system/tailscale.nix

    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "konan";
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    jq
    yq
    htop
    btop
    ripgrep
    fd
  ];

  services.openssh.enable = true;

  homebrew = {
    enable = true;
    brews = [
      "caddy"
      "docker"
      "docker-compose"
      "colima"
    ];
    casks = [];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
