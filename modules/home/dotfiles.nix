{ config, ... }:
{
  _module.args.dotfilesRoot = "${config.home.homeDirectory}/.config/nix-darwin/home/dotfiles";
  _module.args.outOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
}
