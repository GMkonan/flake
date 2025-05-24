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
    ags.url = "github:Aylur/ags";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    zen,
    home-manager,
    hyprland,
    nixos-hardware,
    astal,
    stylix,
    ...
  }: {
    nixosConfigurations = let
      system = "x86_64-linux";

      overlays = import ./overlays/default.nix;
    in {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit zen;
          inherit inputs;
        };

        modules = [
          # Module to apply the overlay to the system's package set
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = [
              overlays
            ];
          })

          ./hosts/desktop/configuration.nix
          ./modules/packages.nix
          ./modules/nixos-shared.nix
          ./modules/1password.nix
          ./modules/tailscale.nix
          ./modules/bootloader.nix
          ./modules/user.nix
          ./modules/default.nix
          ./nvim/default.nix
          ./modules/hyprland.nix
          ./modules/nvidia.nix
          ./modules/gaming.nix

          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          # stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.users.konan = {
              imports = [
                ./home.nix
                inputs.ags.homeManagerModules.default
              ];
            };
          }
        ];
      };

      thinkpad = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit zen;
          inherit inputs;
        };

        modules = [
          # Module to apply the overlay to the system's package set
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = [
              overlays
            ];
          })

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
          # Add Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Configure your user's Home Manager settings
            home-manager.users.konan = {
              imports = [
                ./home.nix
                inputs.ags.homeManagerModules.default
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
