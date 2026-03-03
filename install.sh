#!/bin/bash
set -e

echo "Starting dotfiles installation..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Shell config
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitconfig.work" ~/.gitconfig.work

# Powerlevel10k config
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# WezTerm config
mkdir -p ~/.config/wezterm
ln -sf "$DOTFILES_DIR/.config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua

# TODO: Need to finish this once installed
# Aerospace config

# Neovim config
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim

echo "Dotfiles installed successfully"
