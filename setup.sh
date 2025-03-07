#!/bin/bash
  
 DOT_FILES=(.bashrc .commit_template .gitconfig .profile .config .zshrc)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

