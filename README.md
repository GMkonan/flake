# konan's flake

personal nixos + home-manager setup for a couple machines.

it is mostly:
- host-first
- standalone home-manager
- reusable homes
- theme-driven
- still being cleaned up as i go

the structure is inspired in part by `anotherhadi/nixy`, but adapted to how i prefer to organize hosts, homes, and theming.

## Screenshots

coming soon. i still move things around too much, but when i finally stop shuffling pixels every other day i'll drop them here.

## Structure

- `flake.nix` - inputs and host inventory
- `lib/` - bootstrap logic and flake helpers
- `hosts/` - per-machine `configuration.nix`, `home.nix`, and `vars.nix`
- `homes/` - reusable home-manager bundles like `default` or `minimal`
- `modules/` - reusable nixos and home-manager modules
- `themes/` - one file per theme, shared by system and home
- `overlays/` - package overrides
- `nvim/` - my neovim config
- `assets/` - wallpapers, profile pictures, fetch art, and later screenshots

Current hosts:
- `ryo` - main nixos laptop
- `server` - smaller server-ish setup

## Themes

Themes live in `themes/*.nix`.

Each host picks one in its `vars.nix`:

```nix
{
  theme = "tokyo-night";
}
```

A theme is a normal module that can drive:
- Stylix
- wallpapers and profile images
- window manager colors
- app theming like Fastfetch, tmux, Neovim, Nixcord, and Spicetify

If you want to make a new one, the easiest path is:

1. copy `themes/tokyo-night.nix`
2. rename it
3. change the colors / assets / app settings
4. point a host to it in `hosts/<host>/vars.nix`

Fastfetch uses a single text art file at `assets/fetch/logo.txt`.
If you want a different logo, just replace that file.

#### Todo

##### Nix
- [x] New structure based on https://github.com/anotherhadi/nixy/tree/main
- [x] delete unused packages/config/files, keep it minimal
- [x] Lazygit?
- [x] Add declarative config for a few packages (noctalia, opencode)
- [x] Add opencode-flake
- [x] Nixcord
- [x] Spicetify
- [x] nerdFetch
- [x] make a better theme module thing ala nixy stuff
- [x] fetch dot art
- [x] write a good readme

- [ ] nix utilitys script (nixy like)
- [ ] divide packages on nixos system better
- [ ] have a affinity module
- [ ] create separate modules for brave and zen
- [ ] Fix affinity linux

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

```bash
nix run github:nix-community/nixos-generators -- --format iso --flake .#ryo

nix run github:nix-community/nixos-generators -- --format iso --flake .#ryo -o ryo-iso
```
