{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Required by nix-darwin as the user's login shell.
    fish

    # Darwin-specific applications and tooling.
    dbeaver-bin
    ghostty-bin
    lima
    obsidian
    qemu
    raycast
  ];
}
