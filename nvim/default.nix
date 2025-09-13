{pkgs, ...}: {
  # home.file."nvim".source = ../nvim;
  # Put the whole folder into ~/.config/nvim
  xdg.configFile."nvim".source = ../nvim;

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
