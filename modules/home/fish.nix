{
  dotfilesRoot,
  outOfStoreSymlink,
  pkgs,
  ...
}:
let
  bobthefish = pkgs.fishPlugins.bobthefish;
  bobthefishFunctions = [
    "__bobthefish_colors.fish"
    "__bobthefish_display_colors.fish"
    "__bobthefish_glyphs.fish"
    "bobthefish_display_colors.fish"
    "fish_mode_prompt.fish"
    "fish_prompt.fish"
    "fish_right_prompt.fish"
    "fish_title.fish"
  ];
  bass = pkgs.fishPlugins.bass;
in
{
  home.file = {
    ".config/fish/config.fish".source = outOfStoreSymlink "${dotfilesRoot}/config/fish/config.fish";
    ".config/fish/conf.d".source = outOfStoreSymlink "${dotfilesRoot}/config/fish/conf.d";
    ".config/fish/functions/y.fish".source = outOfStoreSymlink "${dotfilesRoot}/config/fish/functions/y.fish";
    ".config/fish/functions/bass.fish".source = "${bass}/share/fish/vendor_functions.d/bass.fish";
    ".config/fish/functions/__bass.py".source = "${bass}/share/fish/vendor_functions.d/__bass.py";
  }
  // builtins.listToAttrs (
    map (name: {
      name = ".config/fish/functions/${name}";
      value.source = "${bobthefish}/share/fish/vendor_functions.d/${name}";
    }) bobthefishFunctions
  );
}
