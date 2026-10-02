# Apply and Roll Back

## Apply changes

```sh
nix fmt
nix flake check
darwin-rebuild switch --flake .#tob
```

## Inspect generations

```sh
darwin-rebuild --list-generations
```

## Roll back

```sh
darwin-rebuild switch --rollback
```

If a change only affects Home Manager files, applying the darwin configuration is still preferred because Home Manager is wired through nix-darwin in `hosts/tob/home.nix`.
