{ pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.konan = {
      isNormalUser = true;
      description = "konan";
      extraGroups = [ "networkmanager" "wheel" "docker"];
      shell = pkgs.zsh;
      packages = with pkgs; [];
    };
  };
}
