# Flake nix
Nix + home manager config for multiple hosts. Inspired by bocchi the rock
characters.

## Hosts
- Bocchi (Gaming Desktop) WIP
- Ryo (thinkpad L14)
- Seika (mac mini server) WIP

#### Todo

##### Nix
- [ ] fastfetch dot art
- [ ] New structure based on zoe + [this nix config](https://github.com/louis-thevenet/nixos-config/blob/main/README.md)
- [ ] notifications in the middle plugin
- [ ] delete unused packages/config/files, keep it minimal
- [ ] Fix affinity linux
- [ ] Lazygit?
- [ ] Add declarative config for a few packages (noctalia, opencode)

##### Niri
- [ ] Add transparency to other windows

##### Neovim
- [ ] Add supermaven
- [ ] Fix the annoying copy command thing

#### Affinity update command

If you use `affinity-nix`, you can run the graphical updater with:

`nix run github:mrshmllow/affinity-nix#{v3,photo,designer,publisher} -- update`

Examples:

- `nix run github:mrshmllow/affinity-nix#v3 -- update`
- `nix run github:mrshmllow/affinity-nix#photo -- update`



```
nix run github:nix-community/nixos-generators -- --format iso --flake .#ryo

nix run github:nix-community/nixos-generators -- --format iso --flake .#ryo -o ryo-iso
``` 
