set -g fish_greeting

eval (/opt/homebrew/bin/brew shellenv)

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end

alias c='clear'
alias top='btop'
alias tasks='vim ~/tasks.md'
alias vim='nvim'
alias kssh='kitty +kitten ssh'
alias cd="z"
alias code="code -r"

export PATH="$HOME/.local/bin:$PATH"

function marp
  sudo docker run --rm --name marp -v $PWD:/home/marp/app/ -e LANG=$LANG -p 8080:8080 marpteam/marp-cli ./ --server
  sudo docker container stop marp
end

function waydroid-cleanup
    waydroid session stop
    sudo systemctl stop waydroid-container.service
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function kindle
    if not systemctl is-active --quiet waydroid-container.service
        sudo systemctl start waydroid-container.service
        sleep 2
    end

    if not waydroid status &> /dev/null
        waydroid session start &
        sleep 3
    end

    waydroid app launch com.amazon.kindle
end

function load_env
    if test -f ~/.env
        while read -l line
            if not string match -qr '^#|^$' $line
                set -l parts (string split = $line)
                set -gx $parts[1] $parts[2]
            end
        end < ~/.env
    end
end

load_env

zoxide init fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/tob/miniconda3/bin/conda
    eval /Users/tob/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/tob/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/tob/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/tob/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

