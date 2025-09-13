{...}: {
  programs.ghostty = {
    enable = true;

    settings = {
      theme = "catppuccin-mocha";
      font-size = 12;
      background-opacity = 0.9;
      command = "zsh";
    };
  };
}
