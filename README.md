# nix-darwin configuration

Personal nix-darwin and Home Manager configuration for `tob`.

## Layout

- `flake.nix`: flake entrypoint and host registration.
- `hosts/tob`: machine-specific settings and Home Manager wiring.
- `modules/darwin`: reusable nix-darwin modules for packages, Homebrew, Nix, and shell setup.
- `modules/home`: reusable Home Manager modules grouped by tool area.
- `home/dotfiles`: source dotfiles linked by Home Manager.
- `docs`: operational notes and structure conventions.

## Apply

```sh
darwin-rebuild switch --flake .#tob
```

If `darwin-rebuild` is not on `PATH`, use the nix-darwin app from the flake:

```sh
nix run nix-darwin -- switch --flake .#tob
```

## Validate

```sh
nix fmt
nix flake check
```
