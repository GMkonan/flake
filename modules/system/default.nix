{...}: {
  imports = [
    ./packages.nix
    ./nixos-shared.nix
    ./tailscale.nix
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
