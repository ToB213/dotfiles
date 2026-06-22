{ dotfilesRoot, outOfStoreSymlink, ... }:
{
  home.file = {
    ".config/nvim/init.lua".source = outOfStoreSymlink "${dotfilesRoot}/config/nvim/init.lua";
    ".config/nvim/lazy-lock.json".source =
      outOfStoreSymlink "${dotfilesRoot}/config/nvim/lazy-lock.json";
    ".config/nvim/lua".source = outOfStoreSymlink "${dotfilesRoot}/config/nvim/lua";
  };
}
