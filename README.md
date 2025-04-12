# Flake nix

Nix stuff for both my darwin (mac) and linux pcs

## Hosts
- NixOS thinkpad T480
- Darwin (mac mini)
- NixOS Media Server
- Nixos Desktop

### Darwin
darwin-rebuild switch --flake ~/flake#mini

### Nixos
sudo nixos-rebuild switch --flake ~/flake#thinkpad (or other host)

#### Todo
- hyprland
    - [ ] dark theme for applications
    - [ ] resize panels
    - [ ] solve electron issue
    - [ ] change color borders
    - [ ] widgets for hyprland
    - [ ] wallpaper change (change some configs)
- wofi
    - [ ] use catppuccin theme
- waybar
    - [ ] Add pomodoro
