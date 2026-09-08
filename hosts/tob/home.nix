{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.tob = {
    imports = [ ../../home ];
    home.username = "tob";
    home.homeDirectory = "/Users/tob";
    home.stateVersion = "24.11";
  };
}
