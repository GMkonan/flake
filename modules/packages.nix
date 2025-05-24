{pkgs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    obsidian
    brave
    slack
    # discord
    vesktop
    zed-editor
    vscode
    bruno
    helix
    google-chrome

    oh-my-posh
    zoxide
    lsd
    fzf
    fd
    ripgrep
    graphite-cli
    gh
    lazydocker
    nodejs
    bun
    pnpm
    flyctl
    go
    rustup

    ngrok
    silicon

    inputs.myShellFlake.packages.${pkgs.system}.default # The "my-shell" application

    # GObject Introspection dependencies for "my-shell"
    # These ensure GJS can find the typelibs for astal3 and io at runtime.
    inputs.astal.packages.${pkgs.system}.astal3
    inputs.astal.packages.${pkgs.system}.io
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # nerd-fonts.commit-mono
  ];
}
