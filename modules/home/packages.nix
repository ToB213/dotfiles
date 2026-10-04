{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      ansible
      awscli2
      btop
      cloudflared
      clang-tools
      cmake
      fd
      fastfetch
      gh
      git
      git-lfs
      go-task
      helmfile
      imagemagick
      jq
      k9s
      kind
      kubernetes-helm
      kubeseal
      lazygit
      neovim
      ninja
      nix-direnv
      nodejs
      p7zip
      pkg-config
      ripgrep
      shellcheck
      terraform
      tmux
      trash-cli
      tree
      vim
      wget
      yazi
      zoxide
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # On Darwin, fish is installed system-wide because it is the login shell.
      pkgs.fish
    ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
  };
}
