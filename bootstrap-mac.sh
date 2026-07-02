#!/bin/bash
set -e

# =============================================================================
# ASCII ART
# =============================================================================
echo ""
echo "  ███╗   ███╗ █████╗  ██████╗██████╗  ██████╗  ██████╗ ██╗  ██╗    ██████╗ ██████╗  ██████╗ "
echo "  ████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔═══██╗██║ ██╔╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ██╔████╔██║███████║██║     ██████╔╝██║   ██║██║   ██║█████╔╝     ██████╔╝██████╔╝██║   ██║"
echo "  ██║╚██╔╝██║██╔══██║██║     ██╔══██╗██║   ██║██║   ██║██╔═██╗     ██╔═══╝ ██╔══██╗██║   ██║"
echo "  ██║ ╚═╝ ██║██║  ██║╚██████╗██████╔╝╚██████╔╝╚██████╔╝██║  ██╗    ██║     ██║  ██║╚██████╔╝"
echo "  ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ "
echo ""
echo "  ███████╗███████╗████████╗██╗   ██╗██████╗ "
echo "  ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗"
echo "  ███████╗█████╗     ██║   ██║   ██║██████╔╝"
echo "  ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ "
echo "  ███████║███████╗   ██║   ╚██████╔╝██║     "
echo "  ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     "
echo ""

# =============================================================================
# HOMEBREW PATH (Apple Silicon)
# =============================================================================
if ! command -v brew &> /dev/null; then
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# =============================================================================
# HELPERS — don't let one failed install kill the whole script
# =============================================================================
safe_brew_install() {
  if brew install "$1"; then
    echo "✓ Installed: $1"
  else
    echo "✗ FAILED: $1 — skipping, fix manually later"
  fi
}

safe_brew_cask_install() {
  if brew install --cask "$1"; then
    echo "✓ Installed: $1"
  else
    echo "✗ FAILED: $1 — skipping, fix manually later"
  fi
}

# =============================================================================
# HOMEBREW PACKAGES — CLI TOOLS
# =============================================================================
safe_brew_install git
safe_brew_install btop
safe_brew_install eza
safe_brew_install lazygit
safe_brew_install lazydocker
safe_brew_install neovim
safe_brew_install ripgrep
safe_brew_install mas
safe_brew_install coreutils
safe_brew_install git-filter-repo
safe_brew_install gnupg
safe_brew_install aws-iam-authenticator
safe_brew_install awscli
safe_brew_install eksctl
safe_brew_install kubernetes-cli
safe_brew_install k9s
safe_brew_install terraform-docs
safe_brew_install cfn-lint
safe_brew_install zsh
safe_brew_install zplug
safe_brew_install zsh-syntax-highlighting
safe_brew_install yarn
safe_brew_install pyenv
safe_brew_install pyenv-virtualenv
safe_brew_install pipx

# =============================================================================
# TFSWITCH (custom tap)
# =============================================================================
brew tap warrensbox/tap
safe_brew_install warrensbox/tap/tfswitch

# =============================================================================
# TFLINT (custom tap)
# =============================================================================
brew tap terraform-linters/tap
safe_brew_install terraform-linters/tap/tflint

# =============================================================================
# PIPX — PYTHON CLI TOOLS
# =============================================================================
if ! command -v pipx &> /dev/null; then
  echo "Installing pipx via brew..."
  if ! brew install pipx; then
    echo "Brew install failed, trying pip fallback..."
    python3 -m pip install --user pipx
    export PATH="$PATH:$HOME/Library/Python/3.9/bin"
  fi
  python3 -m pipx ensurepath
  echo "✓ Installed: pipx"
else
  echo "✓ Already installed: pipx"
fi

# =============================================================================
# AWSUME
# =============================================================================
if ! pipx list | grep -q awsume; then
  echo "Installing awsume..."
  pipx install awsume
  echo "✓ Installed: awsume"
else
  echo "✓ Already installed: awsume"
fi

# =============================================================================
# HOMEBREW CASKS — DEVELOPMENT TOOLS
# =============================================================================
safe_brew_cask_install devpod
safe_brew_cask_install insomnia
safe_brew_cask_install gpg-suite
safe_brew_cask_install sublime-text

# =============================================================================
# HOMEBREW CASKS — TERMINAL AND WINDOW MANAGEMENT
# =============================================================================
safe_brew_cask_install wezterm
brew tap nikitabobko/tap
safe_brew_cask_install nikitabobko/tap/aerospace

# =============================================================================
# HOMEBREW CASKS — PRODUCTIVITY
# =============================================================================
safe_brew_cask_install raycast
safe_brew_cask_install google-chrome
safe_brew_cask_install notion

# =============================================================================
# HOMEBREW CASKS — UTILITIES
# =============================================================================
safe_brew_cask_install 1password
safe_brew_cask_install nordvpn
safe_brew_cask_install stats

# =============================================================================
# HOMEBREW CASKS — JETBRAINS
# =============================================================================
safe_brew_cask_install jetbrains-toolbox

# =============================================================================
# HOMEBREW CASKS — AI
# =============================================================================
safe_brew_cask_install claude

# =============================================================================
# HOMEBREW CASKS — FONTS
# =============================================================================
safe_brew_cask_install font-meslo-lg-nerd-font

# =============================================================================
# HOMEBREW CASKS — VIRTUALISATION
# =============================================================================
safe_brew_cask_install utm

# =============================================================================
# OH MY ZSH
# =============================================================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "✓ Installed: oh-my-zsh"
else
  echo "✓ Already installed: oh-my-zsh"
fi

# =============================================================================
# POWERLEVEL10K
# =============================================================================
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "✓ Installed: Powerlevel10k"
else
  echo "✓ Already installed: Powerlevel10k"
fi

# =============================================================================
# ZPLUG PLUGINS
# =============================================================================
if [ ! -d "$HOME/.zplug" ]; then
  echo "Installing zplug..."
  curl -sL --proto-redir -all,https \
    https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  echo "✓ Installed: zplug"
else
  echo "✓ Already installed: zplug"
fi

echo "Installing zplug plugins..."
export ZPLUG_PROTOCOL=HTTPS
zsh -c "
  source \$HOME/.zplug/init.zsh
  zplug 'zsh-users/zsh-syntax-highlighting', defer:2
  zplug 'zsh-users/zsh-history-substring-search', defer:3
  zplug 'zsh-users/zsh-autosuggestions'
  zplug 'zsh-users/zsh-completions'
  zplug 'dracula/zsh', as:theme
  zplug install
" || true
echo "✓ Installed: zplug plugins"

# =============================================================================
# MACOS DEFAULTS
# =============================================================================
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 30
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write com.apple.controlcenter BatteryShowPercentage -bool true
echo "✓ macOS keyboard repeat default speeds and battery percentage configured"

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
echo "  ███╗   ███╗ █████╗ ███╗   ██╗██╗   ██╗ █████╗ ██╗      "
echo "  ████╗ ████║██╔══██╗████╗  ██║██║   ██║██╔══██╗██║      "
echo "  ██╔████╔██║███████║██╔██╗ ██║██║   ██║███████║██║      "
echo "  ██║╚██╔╝██║██╔══██║██║╚██╗██║██║   ██║██╔══██║██║      "
echo "  ██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╔╝██║  ██║███████╗ "
echo "  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ "
echo ""
echo "  ███████╗████████╗███████╗██████╗ ███████╗"
echo "  ██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔════╝"
echo "  ███████╗   ██║   █████╗  ██████╔╝███████╗"
echo "  ╚════██║   ██║   ██╔══╝  ██╔═══╝ ╚════██║"
echo "  ███████║   ██║   ███████╗██║     ███████║"
echo "  ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚══════╝"
echo ""
echo "1.  Configure PyCharm:        Open JetBrains Toolbox and install PyCharm Professional"
echo "2.  Configure Gateway:        Open JetBrains Toolbox and install JetBrains Gateway"
echo "3.  Install Docker Desktop:   Download from docker.com/products/docker-desktop (Apple Silicon version)"
echo "4.  Generate a new SSH key for GitHub access:"
echo "     - ssh-keygen -t ed25519 -C aymerjames@gmail.com"
echo "     - ssh-add ~/.ssh/id_ed25519"
echo "     - cat ~/.ssh/id_ed25519.pub"
echo "     - Add the output to GitHub: Settings > SSH and GPG keys > New SSH key"
echo "5.  Configure DevPod:"
echo "     - Add Docker as the provider (DevPod will find Docker automatically)"
echo "     - Set Dotfiles repo to: https://github.com/semaj87/dotfiles.git"
echo "     - Set SSH key path to: ~/.ssh/id_ed25519"
echo "     - Set IDE to None"
echo "6.  Clone templates:           git clone git@github.com:semaj87/devcontainer-templates.git ~/devcontainer-templates"
echo "7.  Download AlmaLinux:        Download AlmaLinux AArch64 (Apple Silicon) ISO from almalinux.org and move to ~/isos/"
echo "8.  Configure UTM — Create a new VM with these exact settings:"
echo "     - Click: Create a New Virtual Machine > Virtualize > Linux"
echo "     - Boot ISO: select AlmaLinux AArch64 ISO from ~/isos/"
echo "     - Enable display output: yes"
echo "     - Use Apple Virtualization: no (uses QEMU)"
echo "     - Architecture: ARM64 (aarch64)"
echo "     - Machine: QEMU 10.0 ARM Virtual Machine (virt)"
echo "     - Memory: 2GB"
echo "     - Storage: 20GB (recommended)"
echo "     - Network: Shared Network (virtio-net-pci)"
echo "     - Name the VM: AlmaLinux"
echo "     - Boot and install AlmaLinux, then eject the ISO when complete"
echo "9.  Get App Store apps:        Install Be Focused Pro, Theine (if desired)"
echo "10. Restore sensitive files:"
echo "     - Copy ~/.zshrc.local from 1Password to a newly created ~/.zshrc.local"
echo "     - Copy ~/.gitconfig.work from 1Password to a newly created ~/.gitconfig.work"
echo "     - Copy ~/.local/bin/tools-access/tools-access.sh from 1Password to a newly created ~/.local/bin/tools-access/tools-access.sh"
echo "     - Run: chmod +x ~/.local/bin/tools-access/tools-access.sh"
echo "11. Install IB Gateway:        Download Apple Silicon version from:"
echo "     https://www.interactivebrokers.com/en/trading/ibgateway-latest.php"
echo "12. Restore AWS config:"
echo "      - Copy ~/.aws/config from 1Password to a newly created ~/.aws/config"
echo "      - Copy ~/.aws/credentials from 1Password to a newly created ~/.aws/credentials"
echo "13. Apply keyboard settings: Log out and back in for keyboard repeat speed to take effect"
echo "      - Apple menu > Log Out > Log back in"
echo ""
