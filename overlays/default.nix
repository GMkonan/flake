inputs: let
  waylandElectron = import ./wayland-electron.nix;
  patchedNoctaliaQuickshell = final: let
    system = final.stdenv.hostPlatform.system;
    quickshell = inputs.noctalia.inputs.noctalia-qs.packages.${system}.default.overrideAttrs (old: {
      patches = (old.patches or []) ++ [../patches/noctalia-qs-session-lock-output-change.patch];
    });
  in {
    noctalia-qs-patched = quickshell;
    noctalia-shell-patched = inputs.noctalia.packages.${system}.default;
  };
in
  final: prev: (waylandElectron final prev) // patchedNoctaliaQuickshell final
