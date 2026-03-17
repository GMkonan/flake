{...}: {
  programs.ghostty = {
    enable = true;

    settings = {
      theme = "Catppuccin Mocha";
      font-size = 13;
      # background-opacity = 1.0;
      command = "zsh";
    };
  };
}
