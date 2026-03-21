{pkgs, ...}: {
  home.packages = with pkgs; [
    # password stuff
    bitwarden-desktop
    _1password-cli
    _1password-gui

    # vpn
    protonvpn-gui

    # music
    spotify

    # db client
    dbeaver-bin
    clickhouse

    # coding
    vscode

    # communication
    slack
    vesktop

    # productivity
    obsidian
    ticktick

    # dev tools
    bruno
    zed-editor

    # MISC
    mpv
    libreoffice
    # figma-linux
    anki
    # davinci-resolve
  ];
}
