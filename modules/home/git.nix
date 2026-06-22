{ dotfilesRoot, outOfStoreSymlink, ... }:
{
  home.file = {
    ".gitconfig".source = outOfStoreSymlink "${dotfilesRoot}/home/git/config";
    ".gitcommit".source = outOfStoreSymlink "${dotfilesRoot}/home/git/commit-template";
  };
}
