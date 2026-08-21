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
    go-task
    neovim
    nix-direnv
    shellcheck

    # Infrastructure
    ansible
    awscli2
    cloudflared
    helmfile
    k9s
    kubernetes-helm
    kubeseal
    qemu
    kind
    terraform

    # Desktop apps and media
    dbeaver-bin
    fish
    ghostty-bin
    imagemagick
    obsidian
    raycast
  ];
}
