function conda --description "Initialize Conda on first use"
    set -l conda_init "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    set -l conda_executable "$HOME/miniconda3/bin/conda"

    functions --erase conda

    if test -f "$conda_init"
        source "$conda_init"
    else if test -x "$conda_executable"
        "$conda_executable" shell.fish hook | source
    else
        echo "conda is not installed" >&2
        return 127
    end

    conda $argv
end
