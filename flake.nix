{
  description = "Konan nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {

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

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      modules = [ 
      configuration 
      ./hosts/mac/configuration.nix
      ./modules/packages.nix
      nix-homebrew.darwinModules.nix-homebrew
      {
      	nix-homebrew = {
		enable = true;
		# Apple Silicon Only
		enableRosetta = true;
		
		user = "konan";
	};
	}
      ];
    };
  };
}
