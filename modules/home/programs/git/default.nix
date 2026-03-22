{pkgs, ...}: {
  home.packages = with pkgs; [
    graphite-cli
    jujutsu
    lazyjj
    lazygit
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "GMkonan";
        email = "guilhemont@hotmail.com";
      };
      alias = {
        staash = "stash --all";
        rblame = "blame -w -C -C -C";
        wdiff = "diff --word-diff";
        cbranch = "branch --column";

        # Now pointing to the managed githelpers
        l = "!. ~/.config/git/githelpers && pretty_git_log";

        safe-push = "push --force-with-lease --force-if-includes";
      };

      apply.whitespace = "fix";
      init.defaultBranch = "main";
      core = {
        compression = 0;
      };

      http.postBuffer = 157286400;
      rerere = {
        enabled = "true";
        autoupdate = "true";
      };
      branch.sort = "-committerdate";
      rebase = {
        updateRefs = "true";
        autoSquash = "true";
        autoStash = "true";
      };
      column.ui = "auto";
      tag.sort = "version:refname";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = "true";
        renames = "true";
      };
      push = {
        default = "simple";
        autoSetupRemote = "true";
        followTags = "true";
      };
      fetch = {
        prune = "true";
        pruneTags = "true";
        all = "true";
      };
      help.autocorrect = "prompt";
      commit.verbose = "true";
      merge.conflictstyle = "zdiff3";
    };
  };

  # Delta configuration moved to top-level programs.delta
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "OneHalfDark";
    };
  };

  # Git helpers script managed by HM
  xdg.configFile."git/githelpers".text = ''
    #!/bin/bash

    HASH="%C(always,yellow)%h%C(always,reset)"
    RELATIVE_TIME="%C(always,green)%ar%C(always,reset)"
    AUTHOR="%C(always,bold blue)%an%C(always,reset)"
    REFS="%C(always,red)%d%C(always,reset)"
    SUBJECT="%s"

    FORMAT="$HASH $RELATIVE_TIME{$AUTHOR{$REFS $SUBJECT"

    pretty_git_log() {
      git log --graph --pretty="tformat:$FORMAT" "$@" |
      column -t -s '{' |
      less -XRS --quit-if-one-screen
    }
  '';
}
