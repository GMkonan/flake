{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;

  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	wofi
  ];

   fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     # nerd-fonts.commit-mono
   ];
}
