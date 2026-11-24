# Neovim

This configuration is managed by Home Manager through `modules/home/neovim.nix`.

## Layout

- `init.lua`: small entrypoint.
- `lua/config`: editor options and lazy.nvim bootstrap.
- `lua/plugins`: plugin specs grouped by feature.
- `lazy-lock.json`: plugin lock file.

## Workflow

Neovim focuses on editing, completion, diagnostics, and file search. Use Yazi or
Finder for file management, a shell for builds and tests, and lazygit for Git.

Language servers are installed by Nix in `modules/home/neovim.nix`; Mason is not
used. Bash, Lua, C/C++, Nix, Python (Pyright and Ruff), Rust, and Zig are enabled
in `lua/plugins/lsp.lua`. Zig itself is in the shared package list.

Nix, Python, and Zig use nixfmt, Ruff, and zig fmt on save. Other languages fall
back to LSP formatting when available; Rust formatting requires rustfmt in PATH.
Project toolchains and dependencies still belong in each project's devShell.

- `<Space>ff`: find files; `<Space>fg`: search text.
- `gd`: definition; `gr`: references; `K`: hover.
- `<Space>rn`: rename; `<Space>ca`: code actions.
- `<Ctrl-Space>`: completion; `<Tab>`: next candidate or snippet.
- `:checkhealth vim.lsp` and `:ConformInfo`: inspect language support.
