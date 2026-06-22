# Structure

This repository keeps the flake entrypoint small and moves behavior into modules.

## Host Layer

`hosts/tob` owns settings that are specific to this Mac:

- primary user
- host platform
- system state version
- Home Manager user attachment

Add another machine by creating a sibling directory under `hosts` and registering it in `flake.nix`.

## Darwin Modules

`modules/darwin` contains system-level configuration:

- `packages.nix`: Nix-installed system packages
- `homebrew.nix`: Homebrew casks
- `nix.nix`: Nix daemon and flake settings
- `shell.nix`: shell and direnv setup

## Home Modules

`modules/home` contains Home Manager configuration grouped by application or workflow:

- `fish.nix`: Fish configuration files
- `neovim.nix`: Neovim configuration files
- `git.nix`: Git dotfiles
- `cli.nix`: miscellaneous CLI dotfiles
- `dotfiles.nix`: shared dotfile root and symlink helper

Keep dotfile contents under `home/dotfiles`; modules should only describe where those files are linked.
Inside `home/dotfiles`, use `config/` for files linked into `$HOME/.config`, `home/` for files linked directly into `$HOME`, and `shared/` for supporting files such as licenses.
