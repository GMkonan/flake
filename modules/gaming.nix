{pkgs, ...}: {
  # For now this is gonna be a module to install stuff
  # That I right now use in linux but want to move to linux
  # hyprland session is where I code but when gaming and stuff
  # I will be on kde (installed here)

  imports = [./steam.nix];

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

  environment.systemPackages = with pkgs; [
    qbittorrent-enhanced
  ];
}
