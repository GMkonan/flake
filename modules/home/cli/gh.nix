{...}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";

      prompt = "enabled";

      # Replicate the defaults I wanted here https://github.com/GMkonan/ghe/tree/main
      aliases = {
        cr = "repo create --source=. --remote=origin --push --private";
      };
    };
  };
}
