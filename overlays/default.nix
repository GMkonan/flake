inputs: let
  waylandElectron = import ./wayland-electron.nix;
  # Backport upstream nixpkgs fix (master f6c763f2) for aseprite + fmt 12.2.
  # fmt 12.2 no longer exposes fmt::format through <fmt/core.h>; aseprite 1.3.18.1
  # includes "fmt/core.h" in src/app/i18n/strings.h and calls fmt::format(...).
  # Guarded so it becomes a no-op once nixpkgs-unstable ships the upstream fix.
  patchedAseprite = final: prev: {
    aseprite = prev.aseprite.overrideAttrs (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          if grep -q '"fmt/core.h"' src/app/i18n/strings.h 2>/dev/null; then
            substituteInPlace src/app/i18n/strings.h \
              --replace-fail '"fmt/core.h"' '"fmt/format.h"'
          fi
        '';
    });
  };
in
  final: prev:
    (inputs.affinity-nix.overlays.default final prev)
    // (waylandElectron final prev)
    // patchedAseprite final prev
