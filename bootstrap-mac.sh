#!/bin/bash
set -e

echo "Setting up your MacBook Pro..."

# =============================================================================
# HOMEBREW PACKAGES — CLI TOOLS
# =============================================================================
brew install git
brew install btop
brew install eza
brew install lazygit
brew install lazydocker
brew install neovim
brew install ripgrep
brew install mas
brew install coreutils
brew install git-filter-repo
brew install gnupg
brew install aws-iam-authenticator
brew install awscli
brew install eksctl
brew install kubernetes-cli
brew install k9s
brew install tfswitch
brew install tflint
brew install terraform-docs
brew install cfn-lint
brew install zsh
brew install zplug
brew install zsh-syntax-highlighting
brew install yarn

# =============================================================================
# HOMEBREW CASKS — DEVELOPMENT TOOLS
# =============================================================================
brew install --cask devpod
brew install --cask insomnia
brew install --cask gpg-suite

# =============================================================================
# HOMEBREW CASKS — TERMINAL AND WINDOW MANAGEMENT
# =============================================================================
brew install --cask wezterm
brew tap nikitabobko/tap
brew install --cask nikitabobko/tap/aerospace

# =============================================================================
# HOMEBREW CASKS — PRODUCTIVITY
# =============================================================================
brew install --cask raycast
brew install --cask google-chrome
brew install --cask notion

# =============================================================================
# HOMEBREW CASKS — UTILITIES
# =============================================================================
brew install --cask 1password
brew install --cask nordvpn
brew install --cask stats

# =============================================================================
# HOMEBREW CASKS — JETBRAINS
# =============================================================================
brew install --cask jetbrains-toolbox

# =============================================================================
# HOMEBREW CASKS — AI
# =============================================================================
brew install --cask claude

# =============================================================================
# HOMEBREW CASKS — FONTS
# =============================================================================
brew install --cask font-meslo-lg-nerd-font

# =============================================================================
# HOMEBREW CASKS — VIRTUALISATION
# =============================================================================
brew install --cask utm

# =============================================================================
# HOME DIRECTORY STRUCTURE
# =============================================================================
mkdir -p ~/work
mkdir -p ~/personal
mkdir -p ~/learning
mkdir -p ~/isos

# =============================================================================
# DOTFILES SYMLINKS
# =============================================================================
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# =============================================================================
# SHELL CONFIG
# =============================================================================
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig

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
# AEROSPACE
# =============================================================================
mkdir -p ~/.config/aerospace
ln -sf "$DOTFILES_DIR/.config/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml

# =============================================================================
# NEOVIM
# =============================================================================
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim

# =============================================================================
# MANUAL STEPS
# =============================================================================
echo ""
echo "Manual steps remaining:"
echo "1. Configure PyCharm:        Open JetBrains Toolbox and install PyCharm Professional"
echo "2. Configure Gateway:        Open JetBrains Toolbox and install JetBrains Gateway"
echo "3. Install Docker Desktop:   Download from docker.com/products/docker-desktop (Apple Silicon version)"
echo "4. Configure DevPod:"
echo "    - Add Docker as the provider (DevPod will find Docker automatically)"
echo "    - Set Dotfiles repo to: https://github.com/semaj87/dotfiles.git"
echo "    - Set SSH key path to: ~/.ssh/id_ed25519"
echo "    - Set IDE to None"
echo "5. Clone templates:           git clone git@github.com:semaj87/devcontainer-templates.git ~/devcontainer-templates"
echo "6. Download AlmaLinux:        Download AlmaLinux AArch64 (Apple Silicon) ISO from almalinux.org and move to ~/isos/"
echo "7. Configure UTM:             Create the AlmaLinux VM in UTM using the AArch64 ISO"
echo "8. Get App Store apps:        Install Be Focused Pro, Theine (if desired)"
echo "9. Restore sensitive files:"
echo "    - Copy ~/.zshrc.local from 1Password"
echo "    - Copy ~/.gitconfig.work from 1Password"
echo "    - Copy ~/.local/bin/tools-access/tools-access.sh from 1Password"
echo "    - Run: chmod +x ~/.local/bin/tools-access/tools-access.sh"
echo "10. Install IB Gateway:       Download Apple Silicon version from:"
echo "     https://www.interactivebrokers.com/en/trading/ibgateway-latest.php"
