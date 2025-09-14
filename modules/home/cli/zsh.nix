{pkgs, ...}: {
  # For now I will still manage zsh myself
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
      tn = "tmux new -s ${PWD:t}";
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
    lsd
    fzf
    fd
    ripgrep
    graphite-cli
    opencode
    ni
    shikane
  ];
}
