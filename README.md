# macOS and Windows/WSL development environment

Personal nix-darwin and Home Manager configuration for `tob`. macOS is managed
with nix-darwin; Windows uses winget for desktop applications and Home Manager
inside WSL2 for the terminal environment.

## Layout

- `flake.nix`: flake entrypoint and host registration.
- `hosts/tob`: machine-specific settings and Home Manager wiring.
- `hosts/tob-wsl`: standalone Home Manager configuration for WSL2.
- `modules/darwin`: reusable nix-darwin modules for packages, Homebrew, Nix, and shell setup.
- `modules/home`: reusable Home Manager modules grouped by tool area.
- `home/dotfiles`: source dotfiles linked by Home Manager.
- `windows/setup.ps1`: idempotent Windows/WSL bootstrap script.
- `docs`: operational notes and structure conventions.

## Apply

```sh
darwin-rebuild switch --flake .#tob
```

If `darwin-rebuild` is not on `PATH`, use the nix-darwin app from the flake:

```sh
nix run nix-darwin -- switch --flake .#tob
```

## Apply on Windows

Open PowerShell and run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\windows\setup.ps1
```

The first run installs Windows applications and Ubuntu on WSL2. If WSL asks
for a reboot or initial Linux user creation, create the user as `tob` and run
the script again. The second run installs Nix, clones this repository to
`~/.config/nix-darwin`, and activates `tob-wsl`.

To use another Ubuntu distribution or repository URL:

```powershell
.\windows\setup.ps1 -Distribution Ubuntu-24.04 -Repository https://github.com/ToB213/dotfiles.git
```

After setup, update the WSL environment from the repository with:

```sh
nixswitch
```

## Validate

```sh
nix fmt
nix flake check
```
