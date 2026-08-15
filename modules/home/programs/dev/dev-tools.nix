{
  inputs,
  lib,
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
    (lib.lowPrio minikube)

    azure-cli
    awscli
    devcontainer
    hugo
    bruno

    # editors
    vscode
    code-cursor
    zed-editor
    inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.default

    # db stuff
    dbeaver-bin
    clickhouse

    # 3D modeling
    sweethome3d.application
    blender

    # Screenshot util for code screenshots via nvim
    silicon

    # inputs.linearis.packages.${pkgs.stdenv.hostPlatform.system}.linearis
    inputs.bootdev.packages.${pkgs.stdenv.hostPlatform.system}.bootdev

    pi-coding-agent
  ];
}
