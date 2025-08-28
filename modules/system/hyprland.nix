{
  inputs,
  pkgs,
  ...
}: {
  # Enable system-wide Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # No settings here as they're managed by Home Manager

    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Keep the XDG portal config
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Keep Wayland environment variables
  #environment.sessionVariables = {
  #  XDG_SESSION_TYPE = "wayland";
  #  XDG_CURRENT_DESKTOP = "Hyprland";
  #};
}
