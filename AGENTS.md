# NixOS Flake Agent Guide

## Build & Deploy
- **Build**: `nix build .#<host>` or `nixos-rebuild build --flake .#<host>`
- **Switch**: `nixos-rebuild switch --flake .#<host>` (NixOS) / `darwin-rebuild switch --flake .#<host>` (Darwin)
- **Home**: `home-manager switch --flake .#<home>`
- **Dev shell**: `nix develop` (provides `os()` and `hm()` helper functions)

## Lint & Format
- **Nix**: `nix fmt` (uses alejandra)
- **Lua**: `stylua .` (2-space indent, 160 column width, AutoPreferSingle quotes)

## Code Style
- **Nix**: 2-space indent, use `let...in` for locals, prefer `inherit` for imports
- **Imports**: Simple list format: `imports = [ ./file.nix ]`
- **Naming**: camelCase for functions/variables, PascalCase for modules/components
- **Files**: lowercase for system configs, descriptive names for modules
- **Structure**: Group related configs in directories with `default.nix` exports

## Testing
- **Nix**: `nix flake check` (validates flake structure)
- **Config**: `nixos-rebuild test --flake .#<host>` (test without switching)
- **ISO**: `nix run github:nix-community/nixos-generators -- --format iso --flake .#<host>`

## Subprojects
- See `quickshell/AGENTS.md` for QML/quickshell guidelines
- See `nvim/` for Neovim Lua configuration
