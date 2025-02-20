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

	nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
	pkgs.neovim
	pkgs.tmux
	pkgs.obsidian
	pkgs.brave
	pkgs.slack
	pkgs.discord
	pkgs.zed-editor
	pkgs.vscode
	
	pkgs.oh-my-posh
	pkgs.zoxide
	pkgs.lsd
	pkgs.bat
	pkgs.fzf
	pkgs.fd
	pkgs.ripgrep
	pkgs.nodejs
	pkgs.bun

	pkgs.silicon

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
	
	fonts.packages = [
		pkgs.nerd-fonts.jetbrains-mono
		pkgs.nerd-fonts.jetbrains-mono
	];
      
      system.defaults = {
        dock.autohide = true;
	dock.persistent-apps = [
	  "/Applications/Ghostty.app"
	  "/Applications/TickTick.app"
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
