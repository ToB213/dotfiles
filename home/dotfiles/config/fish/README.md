# Fish

Fish configuration is split by startup responsibility.

- `config.fish`: minimal interactive shell entrypoint.
- `conf.d/00-env.fish`: environment variables and Homebrew shell setup.
- `conf.d/10-path.fish`: PATH additions.
- `conf.d/20-aliases.fish`: command aliases.
- `conf.d/30-tools.fish`: optional tool integrations.
- `conf.d/40-conda.fish`: optional Miniconda integration.
- `functions/`: autoloaded Fish functions.

Oh My Fish and bobthefish are intentionally not loaded here. If a prompt theme is managed again, prefer a Nix-managed plugin or a small local prompt function.
