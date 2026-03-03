#!/bin/bash
set -e

echo "Setting up your MacBook Pro..."

# Install all host tools via Homebrew
brew install git
brew install --cask podman-desktop
brew install --cask devpod
brew install --cask wezterm
brew tap nikitabobko/tap
brew install --cask nikitabobko/tap/aerospace
brew install --cask raycast
brew install --cask brave-browser
brew install --cask notion
brew install --cask jetbrains-toolbox
brew install --cask jetbrains-gateway
brew install --cask claude
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack

# Create home directory structure
mkdir -p ~/work
mkdir -p ~/personal
mkdir -p ~/learning
mkdir -p ~/isos

# Symlink host config files
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

# Aerospace config
mkdir -p ~/.config/aerospace
ln -sf "$DOTFILES_DIR/.config/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml

# Neovim config
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim

# Manual steps
echo ""
echo "Manual steps remaining:"
echo "1. Configure Pycharm: Open JetBrains Toolbox and install PyCharm Professional"
echo "2. Configure DevPod: Set Podman as the provider and add the dotfiles repo URL in Podman desktop"
echo "3. Configure devcontainer templates: Clone the devcontainer-templates repo in your home directory: git clone git@github.com:semaj87/devcontainer-templates.git"
echo "4. Configure AlmaLinux: Download AlmaLinux minimal ISO from almalinux.org and move to ~/isos/"
echo "5. Configure VirtualBox: Create the AlmaLinux VM in VirtualBox using the ISO"
