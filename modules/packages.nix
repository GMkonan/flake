{ pkgs, ... }: {
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
	discord
	zed-editor
	vscode
	
	oh-my-posh
	zoxide
	lsd
	bat
	fzf
	fd
	ripgrep
	nodejs
	bun

	silicon
  ];

   fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     # nerd-fonts.commit-mono
   ];
}
