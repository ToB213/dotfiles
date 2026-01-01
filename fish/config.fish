set -g fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end

alias c='clear'
alias top='btop'
alias tasks='vim ~/tasks.md'
alias vim='nvim'
alias dots='cd ~/src/dotfiles'
alias kssh='kitty +kitten ssh'

function waydroid-cleanup
    waydroid session stop
    sudo systemctl stop waydroid-container.service
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
