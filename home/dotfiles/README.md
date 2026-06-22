# Dotfiles

Source files linked by Home Manager modules in `../../modules/home`.

## Layout

- `config/`: files that are linked under `$HOME/.config`.
- `home/`: files that are linked directly under `$HOME`.
- `shared/`: licenses and assets that are not linked directly.

## Managed areas

- `config/fish`: interactive shell configuration.
- `config/nvim`: Neovim configuration.
- `config/fastfetch`: fastfetch configuration.
- `home/git`: Git defaults and commit template.
- `home/shell`: fallback shell configuration.

Ghostty is intentionally not managed here yet; it is currently used with its defaults.

## Rules

- Keep target-specific linking in Home Manager, not in this repository.
- Prefer explicit file names over hidden names inside this repository.
- Remove app directories when the app is no longer managed.
