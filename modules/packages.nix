{
  inputs,
  pkgs,
  ...
}: {
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
    jujutsu

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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # nerd-fonts.commit-mono
  ];
}
