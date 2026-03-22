{
  host,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Enabled in whole system but configured via home manager
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;

    users.${host.user} = {
      isNormalUser = true;
      description = host.user;
      extraGroups = ["networkmanager" "wheel" "docker"] ++ (host.extraGroups or []);
      home = host.homeDirectory;
      shell = pkgs.zsh;
      packages = with pkgs; [];
    };
  };

  virtualisation.docker.enable = true;
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}
