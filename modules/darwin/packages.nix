{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core CLI
    btop
    fd
    fastfetch
    gh
    git
    git-lfs
    jq
    p7zip
    ripgrep
    tmux
    trash-cli
    tree
    vim
    wget
    yazi
    zoxide

    # Development
    cargo
    clippy
    go
    go-task
    jdk21
    libiconv
    neovim
    nix-direnv
    nodejs
    openldap
    openssl
    perl
    pkg-config
    python314
    ruff
    rust-analyzer
    rustc
    rustfmt
    uv

    # Infrastructure
    ansible
    awscli2
    cloudflared
    helmfile
    kubernetes-helm
    kubeseal
    qemu
    terraform

    # Desktop apps and media
    dbeaver-bin
    fish
    ghostty-bin
    hugo
    imagemagick
    obsidian
    raycast
    zed-editor
    chatgpt
  ];
}
