#!/bin/bash

set -e  # エラーが発生したら終了

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "======================================"
echo "Dotfiles Installation Script"
echo "======================================"

# 既存の設定ファイルをバックアップ（シンボリックリンクでない場合のみ）
backup_if_exists() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        # 初回のみバックアップディレクトリを作成
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            echo "Created backup directory: $BACKUP_DIR"
        fi
        echo "Backing up $file to $BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
    fi
}

# シンボリックリンクを作成（既に正しいリンクがあればスキップ）
create_symlink() {
    local source=$1
    local target=$2
    
    # ソースファイルが存在しない場合はエラー
    if [ ! -e "$source" ]; then
        echo "Warning: Source file does not exist: $source"
        return 1
    fi
    
    # 既に正しいシンボリックリンクが存在する場合はスキップ
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "Already linked: $target -> $source"
        return 0
    fi
    
    # バックアップ（シンボリックリンクでない実ファイルの場合のみ）
    backup_if_exists "$target"
    
    # 既存のシンボリックリンク（間違ったリンク先）を削除
    if [ -L "$target" ]; then
        echo "Removing incorrect symlink: $target"
        rm "$target"
    fi
    
    echo "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Shell設定
echo ""
echo "Setting up shell configurations..."
create_symlink "$DOTFILES_DIR/shell/bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"

# Git設定
echo ""
echo "Setting up Git configuration..."
if [ -f "$DOTFILES_DIR/gitconfig" ]; then
    create_symlink "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
else
    echo "Warning: gitconfig not found, skipping"
fi

# Git commit template
if [ -f "$DOTFILES_DIR/gitcommit" ]; then
    create_symlink "$DOTFILES_DIR/gitcommit" "$HOME/.gitcommit"
else
    echo "Warning: gitcommit not found, skipping"
fi

# Tmux設定
echo ""
echo "Setting up Tmux configuration..."
if [ -f "$DOTFILES_DIR/tmux.conf" ]; then
    create_symlink "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
else
    echo "Warning: tmux.conf not found, skipping"
fi

# Neovim設定
echo ""
echo "Setting up Neovim configuration..."
mkdir -p "$HOME/.config"
if [ -d "$DOTFILES_DIR/nvim" ]; then
    create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
else
    echo "Warning: nvim directory not found, skipping"
fi

# nix-darwin設定
echo ""
echo "Setting up nix-darwin configuration..."
if [ -d "$DOTFILES_DIR/nix-darwin" ]; then
    # 既に正しいシンボリックリンクがあればスキップ
    if [ -L "/etc/nix-darwin" ] && [ "$(readlink /etc/nix-darwin)" = "$DOTFILES_DIR/nix-darwin" ]; then
        echo "Already linked: /etc/nix-darwin -> $DOTFILES_DIR/nix-darwin"
    else
        # 実ディレクトリが存在する場合はバックアップ
        if [ -d "/etc/nix-darwin" ] && [ ! -L "/etc/nix-darwin" ]; then
            if [ ! -d "$BACKUP_DIR" ]; then
                mkdir -p "$BACKUP_DIR"
            fi
            echo "Backing up /etc/nix-darwin"
            sudo cp -r /etc/nix-darwin "$BACKUP_DIR/"
            sudo rm -rf /etc/nix-darwin
        elif [ -L "/etc/nix-darwin" ]; then
            # 間違ったシンボリックリンクを削除
            echo "Removing incorrect symlink: /etc/nix-darwin"
            sudo rm /etc/nix-darwin
        fi
        
        echo "Creating symlink: /etc/nix-darwin -> $DOTFILES_DIR/nix-darwin"
        sudo ln -sf "$DOTFILES_DIR/nix-darwin" /etc/nix-darwin
        sudo chown -h $(whoami):staff /etc/nix-darwin
    fi
else
    echo "Warning: nix-darwin directory not found, skipping"
fi

# 依存関係のインストール確認
echo ""
echo "======================================"
echo "Checking dependencies..."
echo "======================================"

# Oh My Zshのインストール確認
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ""
    echo "Oh My Zsh is not installed."
    read -p "Do you want to install Oh My Zsh? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Oh My Zshプラグインのインストール
        ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
        
        if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
            echo "Installing zsh-autosuggestions..."
            git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
        fi
        
        if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
            echo "Installing zsh-completions..."
            git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
        fi
    fi
else
    echo "Oh My Zsh is already installed"
fi

# Nixのインストール確認
if ! command -v nix &> /dev/null; then
    echo ""
    echo "Nix is not installed."
    read -p "Do you want to install Nix? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    fi
else
    echo "Nix is already installed"
fi

# nix-darwinの適用
if [ -L "/etc/nix-darwin" ] && command -v nix &> /dev/null; then
    echo ""
    read -p "Do you want to apply nix-darwin configuration? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo darwin-rebuild switch --flake /etc/nix-darwin
    fi
fi

echo ""
echo "======================================"
echo "Installation completed!"
echo "======================================"
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "Backup files are stored in: $BACKUP_DIR"
fi
echo ""
echo "Please restart your shell or run:"
echo "  exec \$SHELL"
echo ""
