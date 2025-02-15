#!/bin/bash
set -e

printf "Creating symlinks in ~/\n\n"

ln -s ~/dotfiles/.gitconfig ~/.gitconfig
echo "Created symlink: .gitconfig"

printf "\nCreating symlinks in ~/.config\n\n"

ln -s ~/dotfiles/nvim ~/.config/nvim
echo "Created symlink: /nvim"

ln -s ~/dotfiles/ghostty ~/.config/ghostty
echo "Created symlink: /ghostty"

ln -s ~/dotfiles/tmux ~/.config/tmux
echo "Created symlink: /tmux"

ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
echo "Created symlink: starship.toml"

printf "\nsourcing relevant files\n\n"
cd ~/.config/tmux
tmux source-file tmux.conf
