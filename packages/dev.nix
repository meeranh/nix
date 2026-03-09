{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version Control
    git
    lazygit
    gitleaks

    # Build Tools
    gcc
    gnumake
    cmake
    pkg-config
    openssl

    # Languages
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      i3ipc
    ]))
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    bun
    go
    rustup
    lua
    luarocks
    jdk21
    maven

    # Languages (cont.)
    php

    # Language Servers
    pyright
    typescript-language-server
    rust-analyzer
    gopls
    clang-tools
    jdt-language-server
    nodePackages.intelephense

    # Containers
    docker-compose
  ];
}
