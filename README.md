# Flake nix
Nix + home manager config for multiple hosts. Inspired by bocchi the rock
characters.

## Hosts
- Bocchi (Gaming Desktop) WIP (30 days linux challenge?)
- Ryo (thinkpad L14)
- Seika (mac mini server) WIP (maybe not?)
- nijika (thinkpad T480) WIP (should probably be just a minimal version of what i have in L14)

#### Todo

##### Nix
- [ ] **Remove pinned nixpkgs input for bitwarden** - Pinned to March 10, 2026 revision (2335b7dfd9a721bcaff65058d6c0a1fabd12e1ac) due to electron 39.8.2 build failure
  - Error: `39-angle-patchdir.patch` fails to apply to `electron/patches/config.json`
  - GitHub Issue: https://github.com/NixOS/nixpkgs/issues/500399
  - Fix: Update nixpkgs after the fix propagates to nixpkgs-unstable, then remove the pin
- [ ] New structure based on https://github.com/anotherhadi/nixy/tree/main
- [ ] Fix affinity linux
- [x] delete unused packages/config/files, keep it minimal
- [x] Lazygit?
- [x] Add declarative config for a few packages (noctalia, opencode)
- [ ] Add opencode-flake
- [ ] Nixcord
- [ ] Spicetify
- [ ] nerdFetch
- [ ] make a better theme module thing ala nixy stuff
- [ ] fetch dot art
- [ ] nix utilitys script (nixy like)
- [ ] divide packages on nixos system better
- [ ] have a affinity module
- [ ] create separate modules for brave and zen



##### Niri
- [ ] Add transparency to other windows

##### Neovim
- [ ] Add supermaven?
- [ ] Config opencode.nvim
- [ ] Add yazi.nvim
- [ ] Add harpoon again
- [ ] Add svelte support
- [ ] snacks nvim welcome extension?
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
