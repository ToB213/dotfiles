alias c="clear"
alias k="kubectl"
alias top="btop"
alias ff="fastfetch"
alias vim="nvim"
alias code="code -r"
alias rm="trash"
if test (uname) = Darwin
    alias nixswitch='sudo darwin-rebuild switch --flake .#tob'
else
    alias nixswitch='home-manager switch --flake .#tob-wsl'
end

if test -x /Applications/Tailscale.app/Contents/MacOS/Tailscale
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
end
