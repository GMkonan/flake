{ pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
	# mac only
	pkgs.karabiner-elements
	pkgs.raycast
        ];
	

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

}
