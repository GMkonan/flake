{...}: {
  programs.ghostty = {
    enable = true;

    settings = {
      theme = "Catppuccin Mocha";
      font-size = 12;
      background-opacity = 0.9;
      command = "zsh";
    };
  };
}
