# Dotfiles

Personal dotfiles managed with nix-darwin and home-manager.

## Quick Start (New Machine)
```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run installation script
./install.sh
```

## Manual Setup

### 1. Install Nix
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

### 3. Create Symlinks
```bash
ln -sf ~/dotfiles/shell/bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/nvim ~/.config/nvim
sudo ln -sf ~/dotfiles/nix-darwin /etc/nix-darwin
```

### 4. Apply nix-darwin Configuration
```bash
sudo darwin-rebuild switch --flake /etc/nix-darwin
```

## Structure
```
dotfiles/
├── nix-darwin/          # nix-darwin configuration
├── shell/               # Shell configurations
│   ├── common.sh
│   ├── bashrc
│   └── zshrc
├── nvim/                # Neovim configuration
├── gitconfig            # Git configuration
├── tmux.conf            # Tmux configuration
├── install.sh           # Installation script
└── README.md
```

## Update
```bash
cd ~/dotfiles
git pull
darwin-rebuild switch --flake /etc/nix-darwin
```
