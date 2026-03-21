{
  description = "Konan nix multi-system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew/main";
    };

    zen = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    affinity-nix = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Temporarily pin nixpkgs for bitwarden-desktop due to electron 39.8.2 build failure
    # See: https://github.com/NixOS/nixpkgs/issues/500399
    nixpkgs-pinned = {
      url = "github:NixOS/nixpkgs/2335b7dfd9a721bcaff65058d6c0a1fabd12e1ac"; # March 10, 2026
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.6.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    import ./lib/bootstrap.nix inputs {
      x86_64-linux = {
        homes.nixos = ./homes/nixos;
        hosts.ryo = ./hosts/ryo;

        hosts.server = ./hosts/server;
        homes.server = ./homes/server;
      };
      # aarch64-darwin = {
      # homes.darwin = ./homes/darwin;
      # hosts.mini = ./hosts/mac;
      # };
    };
}
