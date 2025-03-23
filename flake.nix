{
  description = "Konan nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew/main";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    {
nixosConfigurations = 
	let 
	    system = "x86_64-linux";
  in
  {
    desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [ 
      ./hosts/desktop/configuration.nix
      ./modules/packages.nix
      ./modules/nixos-shared.nix
      ./modules/1password.nix
      ./modules/bootloader.nix
      ./modules/user.nix
      ./modules/default.nix
      # ./modules/nvidia.nix
      ];
    };

thinkpad = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [ 
      ./hosts/thinkpad/configuration.nix
      ./modules/packages.nix
      ./modules/nixos-shared.nix
      ./modules/1password.nix
      ./modules/bootloader.nix
      ./modules/user.nix
      ./modules/default.nix
      ];
    };
  };

    darwinConfigurations = 
	let 
	    system = "aarch64-darwin";
  in
  {
    mini = nix-darwin.lib.darwinSystem {
      inherit system;

      modules = [ 
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

    };
  }
