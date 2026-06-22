{ pkgs, ... }:
{
  programs.direnv.enable = true;
  programs.fish.enable = true;

  users.users.tob.shell = pkgs.fish;
}
