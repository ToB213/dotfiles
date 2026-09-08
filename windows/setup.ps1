[CmdletBinding()]
param(
    [string]$Distribution = "Ubuntu",
    [string]$Repository = "https://github.com/ToB213/dotfiles.git"
)

$ErrorActionPreference = "Stop"

$packages = @(
    "Bitwarden.Bitwarden",
    "Discord.Discord",
    "Docker.DockerDesktop",
    "Git.Git",
    "GitHub.cli",
    "Microsoft.PowerToys",
    "Microsoft.VisualStudioCode",
    "Mozilla.Firefox",
    "Obsidian.Obsidian",
    "SlackTechnologies.Slack",
    "Spotify.Spotify",
    "TheDocumentFoundation.LibreOffice"
)

foreach ($package in $packages) {
    winget install --id $package --exact --accept-package-agreements --accept-source-agreements
}

$installedDistributions = wsl.exe --list --quiet
if ($installedDistributions -notcontains $Distribution) {
    wsl.exe --install --distribution $Distribution
    Write-Host "WSL was installed. Complete the Linux user setup, reboot if requested, then run this script again."
    exit 0
}

$bootstrap = @'
set -euo pipefail

if [ "$(id -un)" != "tob" ]; then
  echo "The WSL user must be named 'tob' for this configuration (current: $(id -un))." >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y curl git xz-utils

if ! command -v nix >/dev/null 2>&1; then
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

. "$HOME/.nix-profile/etc/profile.d/nix.sh"
mkdir -p "$HOME/.config"

if [ -d "$HOME/.config/nix-darwin/.git" ]; then
  git -C "$HOME/.config/nix-darwin" pull --ff-only
else
  git clone "$REPOSITORY" "$HOME/.config/nix-darwin"
fi

mkdir -p "$HOME/.config/nix"
if ! grep -q '^experimental-features.*flakes' "$HOME/.config/nix/nix.conf" 2>/dev/null; then
  printf '%s\n' 'experimental-features = nix-command flakes' >> "$HOME/.config/nix/nix.conf"
fi
nix run github:nix-community/home-manager -- switch --flake "$HOME/.config/nix-darwin#tob-wsl"
'@

wsl.exe --distribution $Distribution -- bash -lc ($bootstrap.Replace('$REPOSITORY', "'$Repository'"))

Write-Host "Windows and WSL development environments are ready."
