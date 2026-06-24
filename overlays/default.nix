inputs: let
  waylandElectron = import ./wayland-electron.nix;
  patchedNoctaliaQuickshell = final: let
    system = final.stdenv.hostPlatform.system;
  in {
    noctalia-qs-patched = inputs.noctalia.inputs.noctalia-qs.packages.${system}.default.overrideAttrs (old: {
      patches = (old.patches or []) ++ [../patches/noctalia-qs-session-lock-output-change.patch];
    });
  };
in
  final: prev: (waylandElectron final prev) // patchedNoctaliaQuickshell final
