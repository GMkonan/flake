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
- [x] check if the catppuccin nix thing is actually working
- change the config of catppuccin to the beeter way you thought of
- hyprland
    - [ ] dark theme for applications
    - [ ] resize panels
    - [ ] solve electron issue
    - [x] change color borders
    - [ ] widgets for hyprland
    - [x] wallpaper change (change some configs)
- wofi
    - [ ] use catppuccin theme
- waybar
    - [ ] Add pomodoro

- server
    - [ ] Manage secrets with sops-nix (for now I'm just not commiting secrets)

#### Some Refs:
- https://github.com/Zakar98k/hyprland-catppuccin-dotz
- https://github.com/elkowar/eww/
- ags
- https://github.com/hyprwm/hyprpaper/issues/108#issuecomment-2119611893
- https://github.com/catppuccin/nix?tab=readme-ov-file
- https://www.reddit.com/r/archlinux/comments/136eaiw/hyprland_with_waybar_config_reloading/
