{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/wallpapers/active/anime-girl-cold-days-ik.jpg"
      ];
      wallpaper = [
        ",~/wallpapers/active/anime-girl-cold-days-ik.jpg"
      ];
    };
  };

  home.packages = with pkgs; [
    hyprpaper
  ];
}
