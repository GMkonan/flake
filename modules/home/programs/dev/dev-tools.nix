{pkgs, ...}: {
  home.packages = with pkgs; [
    # JS/TS ecosystem
    nodejs
    bun
    pnpm
    deno

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

    bootdev-cli
    azure-cli
    devcontainer
    hugo

    # Screenshot util for code screenshots via nvim
    silicon
  ];
}
