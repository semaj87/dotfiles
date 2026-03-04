#!/bin/bash
set -e

echo "Starting dotfiles installation..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# =============================================================================
# SHELL CONFIG
# =============================================================================
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitconfig.work" ~/.gitconfig.work

# =============================================================================
# POWERLEVEL10K
# =============================================================================
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# =============================================================================
# WEZTERM
# =============================================================================
mkdir -p ~/.config/wezterm
ln -sf "$DOTFILES_DIR/.config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua

# =============================================================================
# AEROSPACE (TODO: add once configured)
# =============================================================================

# =============================================================================
# NEOVIM
# =============================================================================
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim

# =============================================================================
# AWSUME
# =============================================================================
awsume-configure --shell zsh

echo "Dotfiles installed successfully"
