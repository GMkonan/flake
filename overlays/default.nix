let
  waylandElectron = import ./wayland-electron.nix;
in
  final: prev: waylandElectron final prev
