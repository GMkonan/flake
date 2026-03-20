{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "lsd -A";
      cd = "z";
      cat = "bat";

      # fzf
      sd = "cd ~ && cd \$(find * -type d | fzf)";
      f = "nvim $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')";

      # tmux
      tn = "tmux new -s \"\$(basename \$PWD)\"";
      tls = "tmux list-sessions";
      ta = "tmux a";

      docker-nuke = "sudo docker system prune -a --volumes";

      # git aliases
      gs = "git status";
      gd = "git diff";
      gl = "git l";
      gc = "git commit -m";
      gcnv = "git commit --no-verify -m";

      # graphite
      gtm = "gt modify --no-verify";

      v = "$EDITOR";

      tt = "sh ~/flake/modules/home/cli/tmux-sesh.sh";
    };

    initContent = ''
      # https://github.com/ghostty-org/ghostty/discussions/4409#discussioncomment-16082114
      bindkey -e
      # ---------------------------------------
      # Secrets file (created manually)
      # ---------------------------------------
      if [ -f "$HOME/.secrets" ]; then
        source "$HOME/.secrets"
      fi

      # Run one-shot command from $CMD env var
      if [ -n "$CMD" ]; then
          cmd="$CMD"
          unset CMD
          eval "$cmd"
      fi
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.readFile ./theme.omp.json);
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    # core
    lsd
    fzf
    fd
    ripgrep
    yazi
    graphite-cli
    jujutsu
    lazyjj
    lazygit
    lazydocker
    ni
    shikane
    kubectl
    minikube
    bootdev-cli
    azure-cli
    devcontainer
    hugo
    silicon
  ];
}
