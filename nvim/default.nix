{
  config,
  host,
  lib,
  pkgs,
  ...
}: {
  home.activation.symlinkNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/.config"
    ln -sfn "${host.paths.flakeDir}/nvim" "${config.home.homeDirectory}/.config/nvim"
  '';

  home.packages = with pkgs; [
    neovim
    gopls
    typescript
    vtsls
    svelte-language-server
    lua-language-server
    yaml-language-server
    nil
    kdePackages.qtdeclarative
    alejandra
    biome
  ];
}
