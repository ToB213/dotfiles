{
  pkgs,
  dotfilesRoot,
  outOfStoreSymlink,
  ...
}:
{
  home.packages = with pkgs; [
    bash-language-server
    lua-language-server
    nil
    nixfmt
    pyright
    ruff
    rust-analyzer
    zls
  ];

  home.file = {
    ".config/nvim/init.lua".source = outOfStoreSymlink "${dotfilesRoot}/config/nvim/init.lua";
    ".config/nvim/lazy-lock.json".source =
      outOfStoreSymlink "${dotfilesRoot}/config/nvim/lazy-lock.json";
    ".config/nvim/lua".source = outOfStoreSymlink "${dotfilesRoot}/config/nvim/lua";
  };
}
