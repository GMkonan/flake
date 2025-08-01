{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
