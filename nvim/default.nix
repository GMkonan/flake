{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    # LSPs
    gopls
    typescript-language-server
    lua-language-server
    yaml-language-server
    nil

    # Formatters
    alejandra
    biome
  ];
}
