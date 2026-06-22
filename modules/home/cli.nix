{ dotfilesRoot, outOfStoreSymlink, ... }:
{
  home.file = {
    ".config/btop/btop.conf".source = outOfStoreSymlink "${dotfilesRoot}/config/btop/btop.conf";
    ".config/fastfetch/config.jsonc".source =
      outOfStoreSymlink "${dotfilesRoot}/config/fastfetch/config.jsonc";
    ".config/fastfetch/logo".source = outOfStoreSymlink "${dotfilesRoot}/config/fastfetch/logo";
    ".bashrc".source = outOfStoreSymlink "${dotfilesRoot}/home/shell/bashrc";
  };
}
