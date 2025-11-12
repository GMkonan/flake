{pkgs, ...}: {
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };

  home.packages = with pkgs; [
    taskwarrior-tui
    taskopen
  ];
}
