{ dotfilesRoot, outOfStoreSymlink, ... }:
{
  home.file = {
    ".config/fish/config.fish".source = outOfStoreSymlink "${dotfilesRoot}/config/fish/config.fish";
    ".config/fish/conf.d".source = outOfStoreSymlink "${dotfilesRoot}/config/fish/conf.d";
    ".config/fish/functions".source = outOfStoreSymlink "${dotfilesRoot}/config/fish/functions";
  };
}
