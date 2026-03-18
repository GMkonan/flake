{pkgs, ...}: {
  home.packages = with pkgs; [
    # password stuff
    bitwarden-desktop
    _1password-cli
    _1password-gui

    # vpn
    protonvpn-gui

    # music
    ytmdesktop
    spotify

    # db client
    dbeaver-bin
    clickhouse

    # coding
    vscode

    # MISC
    mpv
    libreoffice
    # figma-linux
    anki
    # davinci-resolve
  ];
}
