# Flake nix
Nix + home manager config for multiple hosts. Inspired by bocchi the rock
characters.

## Hosts
- Bocchi (Desktop)
- Ryo (thinkpad T480)
- Nijika (mac mini)
- Seika (Server)

### Darwin
darwin-rebuild switch --flake ~/flake#mini

### Nixos
sudo nixos-rebuild switch --flake ~/flake#thinkpad (or other host)

#### Todo

##### V2
I want to setup things differently, which will make me change a lot of the
structure of this flake. will be working this in the v2 branch. Questions:

- fastfetch
    - [ ] seika dot art (server)
    - [ ] ryo dot art (laptop)
    - [ ] nijika dot art (mac mini)

- widgets
    - [ ] ags stuff...

- hyprpaper
    - [ ] day and night wallpapers separated

- waybar
    - [ ] Add pomodoro

- tmux
    - [ ] status stuff? pomodoro on tmux?

- server
    - [ ] Manage secrets with sops-nix (for now I'm just not commiting secrets)
        - https://github.com/Mic92/sops-nix

https://github.com/abenz1267/walker/tree/master

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
