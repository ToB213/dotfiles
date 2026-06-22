if test -x "$HOME/miniconda3/bin/conda"
    eval "$HOME/miniconda3/bin/conda" shell.fish hook | source
else if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    source "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
end
