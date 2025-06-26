{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../nvim/default.nix
    ../../modules/system/packages.nix
    ../../modules/system/tailscale.nix

    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        # Apple Silicon Only
        enableRosetta = true;

        user = "konan";
      };
    }
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    # mac only
    pkgs.karabiner-elements
    pkgs.raycast
  ];

  homebrew = {
    enable = true;
    brews = [
      "graphite"
      "sketchybar"
      "borders"
    ];
    casks = [
      "ghostty"
      "1password"
      "docker"
      "ticktick"
      "aerospace"
      "zen-browser"
      "beekeeper-studio"

      # font
      "font-sf-pro"
      "font-sketchybar-app-font"
    ];
    taps = [
      "nikitabobko/tap"
      "withgraphite/tap"
      "FelixKratz/formulae"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Ghostty.app"
      # "/Applications/TickTick.app"
      "${pkgs.brave}/Applications/Brave Browser.app"
      "${pkgs.slack}/Applications/Slack.app"
      "${pkgs.obsidian}/Applications/Obsidian.app"
    ];
    dock.show-recents = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain._HIHideMenuBar = true;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
  };

  # Necessary for using flakes on this system.
  # nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
