{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "tmux-sesh" (builtins.readFile ./tmux-sesh.sh))
  ];
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
    prefix = "C-Space";

    plugins = with pkgs.tmuxPlugins; [
      fzf-tmux-url
      catppuccin
    ];

    extraConfig =
      #tmux
      ''
        set -g status on
        set -g status-position bottom
        set -s set-clipboard on
        bind-key b set-option status

      '';
  };
}
