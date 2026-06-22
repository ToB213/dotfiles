# Neovim

This configuration is managed by Home Manager through `modules/home/neovim.nix`.

## Layout

- `init.lua`: small entrypoint.
- `lua/config`: editor options and lazy.nvim bootstrap.
- `lua/plugins`: plugin specs grouped by feature.
- `lazy-lock.json`: plugin lock file.

The dashboard is text-only. Image rendering is intentionally not configured.
