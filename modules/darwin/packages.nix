{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Required by nix-darwin as the user's login shell.
    fish

    # Darwin-specific applications and tooling.
    dbeaver-bin
    ghostty-bin
    obsidian
    qemu
    raycast
  ];
}
