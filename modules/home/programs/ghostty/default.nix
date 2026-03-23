{...}: {
  programs.ghostty = {
    enable = true;

    settings = {
      font-size = 13;
      # background-opacity = 1.0;
      command = "zsh";
    };
  };
}
