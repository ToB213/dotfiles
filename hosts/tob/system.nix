{
  system.primaryUser = "tob";
  system.stateVersion = 5;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.tob.home = "/Users/tob";
}
