{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # JS/TS ecosystem
    nodejs
    bun
    pnpm
    deno

    python3

    # Compiled languages
    go
    rustup

    # Deployment
    flyctl

    lazydocker
    ni

    # kubernetes
    kubectl
    minikube

    azure-cli
    devcontainer
    hugo
    bruno

    # editors
    vscode
    code-cursor
    zed-editor

    # db stuff
    dbeaver-bin
    clickhouse

    # Screenshot util for code screenshots via nvim
    silicon

    # inputs.linearis.packages.${pkgs.stdenv.hostPlatform.system}.linearis
    inputs.bootdev.packages.${pkgs.stdenv.hostPlatform.system}.bootdev
  ];
}
