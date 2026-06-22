{
  nix.settings.experimental-features = "nix-command flakes";

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
