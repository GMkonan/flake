{nixpkgs-pinned}: let
  pinned = import ./pinned.nix {inherit nixpkgs-pinned;};
  waylandElectron = import ./wayland-electron.nix;
in
  final: prev:
    (waylandElectron final prev)
    // (pinned final prev)
