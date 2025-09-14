{
  pkgs,
  lib,
  ...
}: {
  home.activation.symlinkNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "/home/konan/flake/nvim" "/home/konan/.config/nvim"
  '';
  # Put the whole folder into ~/.config/nvim

  home.packages = with pkgs; [
    neovim
    # LSPs
    gopls
    typescript-language-server
    svelte-language-server
    lua-language-server
    yaml-language-server
    nil
    kdePackages.qtdeclarative
    # Formatters
    alejandra
    biome
  ];
}
