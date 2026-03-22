inputs @ {
  nixpkgs,
  self,
  ...
}: inventory: let
  lib = nixpkgs.lib.extend (import ./lib.nix inputs);

  inherit (lib) concatStringsSep filterAttrs foldl' hasSuffix mapAttrs' mapAttrsToList nameValuePair recursiveUpdate unique;

  overlay = import ../overlays/default.nix;

  mkPkgs = system:
    import nixpkgs {
      inherit system;
      overlays = [overlay];
      config.allowUnfree = true;
    };

  mkHost = name: entry: let
    system = entry.system;
    path = entry.path;
    homes =
      if entry ? homes
      then lib.coerceToList entry.homes
      else [];
    host =
      (import (path + "/vars.nix"))
      // {
        inherit homes name path system;
      };
    isDarwin = hasSuffix "darwin" system;
  in {
    inherit isDarwin system;

    homeConfig = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs system;
      extraSpecialArgs = {inherit host inputs lib self system;};
      modules = builtins.map (homeName: ../homes/${homeName}.nix) homes ++ [(path + "/home.nix")];
    };

    systemConfig =
      (
        if isDarwin
        then inputs.nix-darwin.lib.darwinSystem
        else nixpkgs.lib.nixosSystem
      )
      {
        inherit system;
        specialArgs = {inherit host inputs lib self system;};
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [overlay];
          }
          path
        ];
      };
  };

  hosts = builtins.mapAttrs mkHost inventory;

  systems = unique (builtins.map (value: value.system) (builtins.attrValues hosts));

  mapSystem = system: let
    pkgs = mkPkgs system;
    hostNames = builtins.attrNames (filterAttrs (_: value: value.system == system) hosts);
    rebuildCommand =
      if hasSuffix "darwin" system
      then "nix run nix-darwin --"
      else "sudo nixos-rebuild";
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = [pkgs.alejandra pkgs.home-manager];

      shellHook = ''
        export PS1='\[\e[1;32m\][${system}:\w]\$\[\e[0m\] '
        echo
        echo "‹os›: ${concatStringsSep ", " hostNames}"
        echo "‹hm›: ${concatStringsSep ", " hostNames}"
        echo

        hm() {
          home-manager switch --flake .#$1
        }

        os() {
          ${rebuildCommand} switch --flake .#$1
        }
      '';
    };
  };

  perSystemOutputs = foldl' recursiveUpdate {} (builtins.map mapSystem systems);

  getConfigurations = predicate: key:
    mapAttrs' (name: value: nameValuePair name value.${key}) (filterAttrs (_: value: predicate value) hosts);

  getOptions = configs: foldl' recursiveUpdate {} (mapAttrsToList (_: value: value.options) configs);
in
  perSystemOutputs
  // {
    overlays.default = overlay;

    darwinConfigurations = getConfigurations (value: value.isDarwin) "systemConfig";
    homeConfigurations = getConfigurations (_: true) "homeConfig";
    inherit lib;
    nixosConfigurations = getConfigurations (value: !value.isDarwin) "systemConfig";

    options = {
      nixos = getOptions self.nixosConfigurations;
      darwin = getOptions self.darwinConfigurations;
      home-manager = getOptions self.homeConfigurations;
    };
  }
