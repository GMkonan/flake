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
  ];
}
