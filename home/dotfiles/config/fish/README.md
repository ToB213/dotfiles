# Fish

Fish configuration is split by startup responsibility.

- `config.fish`: minimal interactive shell entrypoint.
- `conf.d/00-env.fish`: environment variables and Homebrew shell setup.
- `conf.d/10-path.fish`: PATH additions.
- `conf.d/20-aliases.fish`: command aliases.
- `conf.d/30-tools.fish`: optional tool integrations.
- `conf.d/40-conda.fish`: optional Miniconda integration.
- `conf.d/50-prompt.fish`: bobthefish theme options.
- `functions/`: autoloaded Fish functions.

Oh My Fish is intentionally not loaded here. bobthefish functions are sourced from the Nix-managed `pkgs.fishPlugins.bobthefish` package in `modules/home/fish.nix`.
