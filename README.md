# Flake nix
Nix + home manager config for multiple hosts. Inspired by bocchi the rock
characters.

## Hosts
- Bocchi (Gaming Desktop) WIP
- Ryo (thinkpad L14)
- Seika (mac mini server) WIP

#### Todo

##### Nix
- [ ] **Remove pinned nixpkgs input for bitwarden** - Pinned to March 10, 2026 revision (2335b7dfd9a721bcaff65058d6c0a1fabd12e1ac) due to electron 39.8.2 build failure
  - Error: `39-angle-patchdir.patch` fails to apply to `electron/patches/config.json`
  - GitHub Issue: https://github.com/NixOS/nixpkgs/issues/500399
  - Fix: Update nixpkgs after the fix propagates to nixpkgs-unstable, then remove the pin
- [ ] fastfetch dot art
- [ ] New structure based on zoe + [this nix config](https://github.com/louis-thevenet/nixos-config/blob/main/README.md)
- [ ] delete unused packages/config/files, keep it minimal
- [ ] Fix affinity linux
- [x] Lazygit?
- [x] Add declarative config for a few packages (noctalia, opencode)

##### Niri
- [ ] Add transparency to other windows

##### Neovim
- [ ] Add supermaven
- [ ] Add svelte support
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
