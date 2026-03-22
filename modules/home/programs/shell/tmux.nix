{
  config,
  pkgs,
  ...
}: let
  theme =
    if config ? theme
    then config.theme.active
    else {
      colors = {
        accent = "#9ece6a";
        background = "#1a1b26";
        primary = "#7aa2f7";
        surface = "#24283b";
        text = "#a9b1d6";
        textMuted = "#565f89";
        warning = "#e0af68";
      };
    };
in {
  home.packages = [
    (pkgs.writeShellScriptBin "tmux-sesh" (builtins.readFile ./tmux-sesh.sh))
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
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
      # vim-tmux-navigator
      fzf-tmux-url
    ];

    extraConfig =
      #tmux
      ''
        set -g status on
        set -g status-position bottom
        set -s set-clipboard on
        bind-key b set-option status

        set -g status-style "bg=${theme.colors.surface},fg=${theme.colors.text}"
        set -g message-style "bg=${theme.colors.primary},fg=${theme.colors.background}"
        set -g pane-border-style "fg=${theme.colors.textMuted}"
        set -g pane-active-border-style "fg=${theme.colors.primary}"
        set -g window-status-style "fg=${theme.colors.textMuted},bg=${theme.colors.surface}"
        set -g window-status-current-style "fg=${theme.colors.background},bg=${theme.colors.accent},bold"
        set -g window-status-format " #I:#W "
        set -g window-status-current-format " #I:#W "
        set -g status-left-length 32
        set -g status-right-length 64
        set -g status-left "#[fg=${theme.colors.background},bg=${theme.colors.primary},bold] #S #[fg=${theme.colors.primary},bg=${theme.colors.surface}]|"
        set -g status-right "#[fg=${theme.colors.warning},bg=${theme.colors.surface}] %H:%M #[fg=${theme.colors.textMuted},bg=${theme.colors.surface}] #(uptime | sed 's/^.*up //; s/, [0-9]* user.*//') "
      '';
  };
}
