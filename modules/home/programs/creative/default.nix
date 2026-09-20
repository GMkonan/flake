{pkgs, ...}: {
  home.packages = with pkgs; [
    # affinity-v3 remains available through the affinity-nix overlay, but is
    # excluded here because its proprietary installer download is unreliable.
    aseprite
    blender
    sweethome3d.application
  ];
}
