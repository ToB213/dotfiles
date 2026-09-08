{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ansible
    awscli2
    btop
    cloudflared
    fd
    fastfetch
    gh
    fish
    git
    git-lfs
    go-task
    helmfile
    jq
    k9s
    kind
    kubernetes-helm
    kubeseal
    neovim
    nix-direnv
    p7zip
    ripgrep
    shellcheck
    terraform
    tmux
    trash-cli
    tree
    wget
    yazi
    zoxide
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
  };
}
