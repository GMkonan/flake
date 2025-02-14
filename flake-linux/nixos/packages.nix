{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;

  };

   # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # nano is installed by default!

  # Desktop apps
  discord
  obsidian
  brave
  kitty
  wofi

  # coding
  gcc
  gnumake
  nodejs
  # python

  # CLI
  wget
  git
  neovim
  vim
  fastfetch
  fzf
  ripgrep
  # check those below before blindly installing
  #lsd
  #lazydocker
  #lazygit
  #zoxide
  #bat

  # Other
  home-manager
  (catppuccin-sddm.override { flavor = "mocha"; })
  # Window manager stuff (WM)
  # hyprland
  waybar
  ];

   fonts.packages = with pkgs; [
     jetbrains-mono
     commit-mono
     font-awesome
     noto-fonts
     noto-fonts-emoji
     twemoji-color-font
     powerline-fonts
     powerline-symbols
     (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
   ];
}
