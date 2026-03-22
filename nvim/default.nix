{
  config,
  host,
  lib,
  options,
  pkgs,
  ...
}: let
  themeName =
    if options ? theme
    then config.theme.name
    else null;

  nvimColorscheme =
    if themeName == "tokyo-night"
    then "tokyonight-night"
    else "tokyonight-night";

  siliconTheme =
    if themeName == "tokyo-night"
    then "Dracula"
    else "Dracula";
in {
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

  home.sessionVariables = lib.mkIf (options ? theme) {
    KONAN_NVIM_COLORSCHEME = nvimColorscheme;
    KONAN_NVIM_SILICON_THEME = siliconTheme;
  };
}
