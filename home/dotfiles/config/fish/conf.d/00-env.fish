if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

set -gx KUBECONFIG "$HOME/.kube/homelab.yaml"
