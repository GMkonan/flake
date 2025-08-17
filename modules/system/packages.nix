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
    tmux
    obsidian
    brave
    slack
    # discord
    vesktop
    zed-editor
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
    lazygit
    nodejs
    bun
    pnpm
    flyctl
    go
    rustup

    ngrok
    silicon

    (inputs.quickshell.packages.${pkgs.system}.default.override {
      withWayland = true;
      withX11 = false;
      withHyprland = true;
    })
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # nerd-fonts.commit-mono
  ];
}
