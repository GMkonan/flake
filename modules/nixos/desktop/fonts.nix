{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    material-symbols
    material-icons
    roboto
  ];
}
