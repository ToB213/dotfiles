#!/bin/bash

set -e

echo "Setting up dotfiles..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

create_symlink() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ]; then
        echo "Backing up existing $dest to $dest.backup"
        mv "$dest" "$dest.backup"
    fi
    
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "Created symlink: $dest -> $src"
}

# Symlinks
create_symlink "$DOTFILES_DIR/btop/btop.conf" "$HOME/.config/btop/btop.conf"
create_symlink "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
if [ -d "$DOTFILES_DIR/fish/functions" ]; then
    create_symlink "$DOTFILES_DIR/fish/functions" "$HOME/.config/fish/functions"
fi
create_symlink "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
create_symlink "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/git/gitcommit" "$HOME/.gitcommit"

# .env setup
if [ ! -f "$HOME/.env" ]; then
    echo "Creating .env file from template..."
    cp "$DOTFILES_DIR/.env.example" "$HOME/.env"
    echo ""
    echo "⚠️  IMPORTANT: Please edit ~/.env and set your Git name and email:"
    echo "   vim ~/.env"
    echo ""
fi

echo "Dotfiles setup complete!"
