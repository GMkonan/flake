{
  config,
  host,
  lib,
  options,
  pkgs,
  ...
}: let
  nvimTheme = {
    plugin = lib.attrByPath ["programs" "nvim" "plugin"] "tokyonight" (config.theme.active or {});
    colorscheme = lib.attrByPath ["programs" "nvim" "colorscheme"] "tokyonight-night" (config.theme.active or {});
    siliconTheme = lib.attrByPath ["programs" "nvim" "siliconTheme"] "Dracula" (config.theme.active or {});
  };
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
    KONAN_NVIM_COLORSCHEME = nvimTheme.colorscheme;
    KONAN_NVIM_SILICON_THEME = nvimTheme.siliconTheme;
    KONAN_NVIM_THEME_PLUGIN = nvimTheme.plugin;
  };
}
