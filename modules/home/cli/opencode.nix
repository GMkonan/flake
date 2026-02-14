{ config, pkgs, ... }: {
  # Opencode configuration
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    plugins = [ "opencode-devcontainers" ];
  };

  # Ensure devcontainer CLI is available (required for devcontainers plugin)
  home.packages = with pkgs; [
    devcontainer
  ];
}
