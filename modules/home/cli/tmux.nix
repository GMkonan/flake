{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";

    mouse = true;
    focusEvents = true;
    aggressiveResize = true;
    clock24 = true;

    historyLimit = 50000;
    escapeTime = 50;

    # keyMode = "vi";
    # prefix = "C-t";

    plugins = with pkgs.tmuxPlugins; [
      fzf-tmux-url
      catppuccin
    ];

    extraConfig =
      #tmux
      ''
        set -g status on
        set -s set-clipboard on
        bind-key b set-option status

      '';
  };
}
