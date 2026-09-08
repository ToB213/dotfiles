{
  imports = [
    ../../home
    ../../modules/home/packages.nix
  ];

  home.username = "tob";
  home.homeDirectory = "/home/tob";
  home.stateVersion = "24.11";

  targets.genericLinux.enable = true;
}
