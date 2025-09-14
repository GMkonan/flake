{
  pkgs,
  lib,
  ...
}: {
  home.activation.symlinkQuickshell = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "/home/konan/flake/quickshell" "/home/konan/.config/quickshell"
  '';

  # home.packages = with pkgs; [
  # ];
}
