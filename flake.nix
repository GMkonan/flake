{
  description = "Konan nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew/main";
    zen.url = "github:youwen5/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    zen,
    home-manager,
    hyprland,
    catppuccin,
  }: {
    nixosConfigurations = let
      system = "x86_64-linux";
    in {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit zen;
        };

        modules = [
          ./hosts/desktop/configuration.nix
          ./modules/packages.nix
          ./modules/nixos-shared.nix
          ./modules/1password.nix
          ./modules/tailscale.nix
          ./modules/bootloader.nix
          ./modules/user.nix
          ./modules/default.nix
          # ./modules/nvidia.nix
        ];
      };

      thinkpad = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit zen;
        };

        modules = [
          ./hosts/thinkpad/configuration.nix
          ./modules/packages.nix
          ./modules/nixos-shared.nix
          ./modules/1password.nix
          ./modules/tailscale.nix
          ./modules/bootloader.nix
          ./modules/user.nix
          ./modules/default.nix
          ./modules/hyprland.nix
          ./nvim/default.nix
          catppuccin.nixosModules.catppuccin
          # Add Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Configure your user's Home Manager settings
            home-manager.users.konan = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/server/configuration.nix
        ];
      };
    };

    darwinConfigurations = let
      system = "aarch64-darwin";
    in {
      mini = nix-darwin.lib.darwinSystem {
        inherit system;

        modules = [
          ./hosts/mac/configuration.nix
          ./modules/packages.nix
          ./modules/tailscale.nix
          ./nvim/default.nix
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
