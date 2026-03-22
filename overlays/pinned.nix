{nixpkgs-pinned}: final: prev: {
  # Temporarily pin bitwarden-desktop due to electron 39.8.2 build failure
  # See: https://github.com/NixOS/nixpkgs/issues/500399
  # Error: 39-angle-patchdir.patch failed at electron/patches/config.json
  bitwarden-desktop = nixpkgs-pinned.legacyPackages.${prev.system}.bitwarden-desktop;
}
