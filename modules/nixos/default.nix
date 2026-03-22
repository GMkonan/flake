{...}: {
  imports = [
    ./packages.nix
    ./tailscale.nix
    ./vpn.nix
    ./bootloader.nix
    ./user.nix
    ./gc.nix
    ./audio.nix
    ./auto-upgrade.nix
    ./locale.nix
    ./niri.nix
    ./fonts.nix
  ];
}
