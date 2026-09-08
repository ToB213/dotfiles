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

## Windows and WSL2

Run `windows/setup.ps1` from PowerShell. The script installs Windows desktop
applications with winget and activates the `tob-wsl` Home Manager profile in
Ubuntu. WSL's initial user must be named `tob`.

Apply later changes from WSL:

```sh
cd ~/.config/nix-darwin
home-manager switch --flake .#tob-wsl
```

Inspect and roll back Home Manager generations:

```sh
home-manager generations
home-manager switch --rollback
```
