inputs @ {
  nixpkgs,
  self,
  ...
}: systems: let
  # system agnostic lib with custom extensions
  lib = nixpkgs.lib.extend (import ./lib.nix inputs);

  inherit (lib) foldl recursiveUpdate mapAttrsToList;

  mapSystem = system: {
    homes ? {},
    hosts ? {},
  }: let
    pkgs = nixpkgs.legacyPackages.${system};

    systemSpecifics =
      if pkgs.stdenv.isDarwin
      then {
        fn = lib.darwinSystem;
        option = "darwinConfigurations";
        command = "nix run nix-darwin --";
      }
      else {
        fn = lib.nixosSystem;
        option = "nixosConfigurations";
        command = "sudo nixos-rebuild";
      };

    mapHosts = builtins.mapAttrs (hostName: path:
      systemSpecifics.fn {
        inherit system;
        specialArgs = {inherit inputs lib self system hostName;};
        modules = [path] ++ lib.autoloadedModules;
      });

    mapHomes = builtins.mapAttrs (homeName: path:
      lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs lib system homeName;};
        modules = [path] ++ lib.autoloadedModules;
      });
  in {
    formatter.${system} = pkgs.alejandra;
    devShells.${system}.default = pkgs.mkShell {
      packages = [pkgs.alejandra pkgs.home-manager];
      shellHook = ''
        export PS1='\[\e[1;32m\][${system}:\w]\$\[\e[0m\] '
        echo
        echo "‹os›: ${builtins.concatStringsSep ", " (builtins.attrNames hosts)}"
        echo "‹hm›: ${builtins.concatStringsSep ", " (builtins.attrNames homes)}"
        echo

        hm() {
          home-manager switch --flake .#$1
        }

        os() {
          ${systemSpecifics.command} switch --flake .#$1
        }
      '';
    };
    ${systemSpecifics.option} = mapHosts hosts;
    homeConfigurations = mapHomes homes;
  };

  configuration = foldl recursiveUpdate {} (mapAttrsToList mapSystem systems);

  getOptions = configs: foldl recursiveUpdate {} (mapAttrsToList (_: value: value.options) configs);
in
  configuration
  // {
    inherit lib;

    # Merge all options into one attribute set for use with ‹nixd›
    options = {
      nixos = getOptions self.nixosConfigurations;
      darwin = getOptions self.darwinConfigurations;
      home-manager = getOptions self.homeConfigurations;
    };
  }
