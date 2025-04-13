{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # LSPs
    gopls
    typescript-language-server
    lua-language-server
    yaml-language-server

    # Formatters
    alejandra
    biome

  ];
}
