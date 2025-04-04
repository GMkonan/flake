{ config, lib, pkgs, ... }:

{
  # Enable system-wide Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # No settings here as they're managed by Home Manager
  };
  
  # Keep the XDG portal config
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Keep Wayland environment variables
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}
