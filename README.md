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
- [x] make catppuccin config be enable for everything in home manager
- [ ] check catppuccin gtk being not supported, and see what you can do
- [ ] Make thinkpad suspend on idle for more than 20 minutes
- hyprland
    - [x] resize panels
    - [ ] solve electron issue
    - [ ] widgets for hyprland (ags? Astal?)
    - [x] change color borders
    - [x] wallpaper change (change some configs)
- wofi
    - [x] use catppuccin theme
- waybar
    - [ ] Add pomodoro
    - [ ] Add notification via dunst on waybar? Search dunst customization
        - also search how to test dunst notifications

- home manager
    - [ ] pass some of the packages to install via home manager (more config options through it)
    - [ ] add home manager to other of my hosts 
        - and divide home packages better to make it work for other hosts

- server
    - [ ] Manage secrets with sops-nix (for now I'm just not commiting secrets)
    - [x] Add tailscale (to access server services on other pcs/networks)

- Nix
    - [ ] Delete useless stuff from configuration.nix from hosts and etc, module it better
    - [x] Add gc 30 days to other hosts to cleanup generations

- Desktop
    - [ ] Change its name to something else (character name?)
    - [ ] fix kde/gaming stuff
        - [ ] scroll issue
        - [ ] brave is not working
        - [ ] test steam

#### Some Refs:
- https://github.com/hyprwm/Hyprland/discussions/192#discussioncomment-12845902
(chrome/electron flickering in hyprland fix)
- https://github.com/Zakar98k/hyprland-catppuccin-dotz
- https://github.com/elkowar/eww/
- ags
- https://github.com/hyprwm/hyprpaper/issues/108#issuecomment-2119611893
- https://github.com/catppuccin/nix?tab=readme-ov-file
- https://www.reddit.com/r/archlinux/comments/136eaiw/hyprland_with_waybar_config_reloading/
- https://github.com/elliottminns/dotfiles/blob/main/nix/home/hyprland.nix
