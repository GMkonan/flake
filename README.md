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
    - [ ] widgets for hyprland (ags? Astal?)
- hyprpaper
    - [ ] day and night wallpapers separated

- waybar
    - [ ] Add pomodoro

- server
    - [ ] Manage secrets with sops-nix (for now I'm just not commiting secrets)

- Nix
    - [ ] Delete useless stuff from configuration.nix from hosts and etc, module it better

#### Some Refs:
- https://github.com/hyprwm/Hyprland/discussions/192#discussioncomment-12845902
(chrome/electron flickering in hyprland fix)
- https://github.com/Zakar98k/hyprland-catppuccin-dotz
- https://github.com/elkowar/eww/
- https://aylur.github.io/ags/
- https://github.com/hyprwm/hyprpaper/issues/108#issuecomment-2119611893
- https://github.com/catppuccin/nix?tab=readme-ov-file
- https://www.reddit.com/r/archlinux/comments/136eaiw/hyprland_with_waybar_config_reloading/
- https://github.com/elliottminns/dotfiles/blob/main/nix/home/hyprland.nix
