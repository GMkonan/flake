{
  config,
  host,
  lib,
  options,
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

  home.sessionVariables = lib.mkIf (options ? theme) {
    KONAN_NVIM_COLORSCHEME = config.theme.active.apps.nvim.colorscheme;
    KONAN_NVIM_SILICON_THEME = config.theme.active.apps.nvim.siliconTheme;
  };
}
