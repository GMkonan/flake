{
  description = "Konan nix multi-system flake";

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
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs:
    import ./lib/bootstrap.nix inputs {
      x86_64-linux = {
        homes.nixos = ./homes/nixos;
        hosts.desktop = ./hosts/desktop;
        hosts.thinkpad = ./hosts/thinkpad;

        hosts.server = ./hosts/server;
        homes.server = ./homes/server;
      };
      aarch64-darwin = {
        # homes.darwin = ./homes/darwin;
        hosts.mini = ./hosts/mac;
      };
    };
}
