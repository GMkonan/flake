{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "GMkonan";
    userEmail = "guilhemont@hotmail.com";

    aliases = {
      staash = "stash --all";
      rblame = "blame -w -C -C -C";
      wdiff = "diff --word-diff";
      cbranch = "branch --column";

      # Now pointing to the managed githelpers
      l = "!. ~/.config/git/githelpers && pretty_git_log";

      safe-push = "push --force-with-lease --force-if-includes";
    };

    extraConfig = {
      apply.whitespace = "fix";
      init.defaultBranch = "main";
      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        compression = 0;
      };
      interactive.diffFilter = "diff-so-fancy --patch";

      color.ui = "true";
      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };
      "color \"diff\"" = {
        meta = "11";
        frag = "magenta bold";
        func = "146 bold";
        commit = "yellow bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };

      http.postBuffer = 157286400;
      rerere = {
        enabled = "true";
        autoupdate = "true";
      };
      branch.sort = "-committerdate";
      maintenance.repo = "/Users/konan/code/work/zapper-dashboard";
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

  home.packages = with pkgs; [diff-so-fancy];

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
