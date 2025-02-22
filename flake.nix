{
  description = "Konan nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    {
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
