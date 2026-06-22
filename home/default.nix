{
  imports = [
    ../modules/home/dotfiles.nix
    ../modules/home/cli.nix
    ../modules/home/fish.nix
    ../modules/home/git.nix
    ../modules/home/neovim.nix
  ];

  home.username = "tob";
  home.homeDirectory = "/Users/tob";
  home.stateVersion = "24.11";
}
