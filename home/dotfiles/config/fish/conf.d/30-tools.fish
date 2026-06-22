if type -q mkcd-bin
    mkcd-bin --init fish | source
end

if type -q zoxide
    zoxide init --cmd cd fish | source
end
