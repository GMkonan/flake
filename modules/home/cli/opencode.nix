{ config, pkgs, ... }: let
  opencodeConfig = {
    plugin = [ "opencode-devcontainers" ];
  };
in {
  # Create opencode config using activation script so opencode can modify it
  home.activation.createOpencodeConfig = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "${config.home.homeDirectory}/.config/opencode"
    if [ ! -f "${config.home.homeDirectory}/.config/opencode/opencode.json" ]; then
      $DRY_RUN_CMD ${pkgs.jq}/bin/jq -n '${builtins.toJSON opencodeConfig}' > "${config.home.homeDirectory}/.config/opencode/opencode.json"
      $DRY_RUN_CMD chmod 644 "${config.home.homeDirectory}/.config/opencode/opencode.json"
    fi
  '';

  # Ensure devcontainer CLI is available (required for devcontainers plugin)
  home.packages = with pkgs; [
    devcontainer
    jq  # Required for the activation script
  ];
}
