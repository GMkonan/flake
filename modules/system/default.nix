{...}: {
  imports = [
    ./packages.nix
    ./nixos-shared.nix
    ./tailscale.nix
    ./vpn.nix
    ./hyprland.nix
    ../../nvim
    ./bootloader.nix
    ./user.nix
    ./gc.nix
    ./audio.nix
    ./auto-upgrade.nix
    ./locale.nix
  ];
}
