{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    obsidian
    ticktick
    anki
    libreoffice

    inputs.zennotes.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
