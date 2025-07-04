{pkgs, ...}: {
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

      {
        # Catppuccin theme config
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_status_style "basic"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_window_default_background "#{thm_black}"
          set -g @catppuccin_window_current_background "#{thm_gray}"
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_status_enable "yes"
          set -g @catppuccin_window_status_icon_enable "no"
          set -g status-right "#{E:@catppuccin_status_uptime}"
          set -g status-left "#{E:@catppuccin_status_session}"
          set -g @catppuccin_window_current_number_color "#{@thm_blue}"
        '';
      }
    ];

    extraConfig =
      #tmux
      ''
        set -g status on
        set -g status-position bottom
        set -s set-clipboard on
        bind-key b set-option status

        # set -g @catppuccin_flavour 'mocha' # or latte, frappe, macchiato, mocha
        # set -g @catppuccin_window_status_style "basic"
        # set -g status-right-length 100

        # set -g status-right "#{E:@catppuccin_status_application}#{E:@catppuccin_status_session}"
        # set -g status-left ""
        # set -g status-right-length 100
        # set -g status-left-length 100
        # set -g status-left ""
        # set -ag status-right ""
        # set -ag status-right "#{E:@catppuccin_status_session}"
        # set -ag status-right "#{E:@catppuccin_status_uptime}"

        # set -g @catppuccin_window_current_number_color "#{@thm_blue}"

                            # set -g @catppuccin_window_right_separator ""
                            # # set -g @catppuccin_window_right_separator "█"
                            # set -g @catppuccin_window_left_separator ""
                            # # set -g @catppuccin_window_left_separator ""
                            # set -g @catppuccin_window_number_position "left"
                            # set -g @catppuccin_window_middle_separator " "
                            # set -g @catppuccin_window_default_text "#W"
                            # set -g @catppuccin_window_default_fill "none"
                            # set -g @catppuccin_window_current_fill "all"
                            # set -g @catppuccin_window_current_text "#W"
                            # set -g @catppuccin_status_modules_right "user host session"
                            # set -g @catppuccin_status_left_separator  " "
                            # # set -g @catppuccin_status_left_separator "█"
                            # set -g @catppuccin_status_right_separator ""
                            # # set -g @catppuccin_status_right_separator "█"
                            # set -g @catppuccin_status_right_separator_inverse "no"
                            # set -g @catppuccin_status_fill "all"
                            # set -g @catppuccin_status_connect_separator "no"
                            # set -g @catppuccin_directory_text "#{pane_current_path}"

                          # set -g @catppuccin_[module_name]_[option] ""
      '';
  };
}
