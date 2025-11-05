#!/bin/sh

DOTFILES_DIR=$(cd $(dirname $0); pwd)

ln -sfv "${DOTFILES_DIR}/.gitcommit" "${HOME}/.gitcommit"
ln -sfv "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -sfv "${DOTFILES_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -sfv "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
ln -sfv "${DOTFILES_DIR}/.bashrc" "${HOME}/.bashrc"

mkdir -p "${HOME}/.config"
ln -sfv "${DOTFILES_DIR}/nvim" "${HOME}/.config/"

echo "Ok"
