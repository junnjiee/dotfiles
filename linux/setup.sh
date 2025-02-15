#!/bin/bash
set -e

dotfiles_dir=~/dotfiles

printf "Creating symlinks in ~/\n\n"

ln -s $dotfiles_dir/.gitconfig ~/.gitconfig
echo "Created symlink: .gitconfig"

printf "\nCreating symlinks in ~/.config\n\n"

ln -s $dotfiles_dir/nvim ~/.config/nvim
echo "Created symlink: /nvim"

ln -s $dotfiles_dir/ghostty ~/.config/ghostty
echo "Created symlink: /ghostty"

ln -s $dotfiles_dir/tmux ~/.config/tmux
echo "Created symlink: /tmux"

ln -s $dotfiles_dir/starship.toml ~/.config/starship.toml
echo "Created symlink: starship.toml"

printf "\nsourcing relevant files\n\n"
cd ~/.config/tmux
tmux source-file tmux.conf
