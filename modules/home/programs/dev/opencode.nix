{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.opencode-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
