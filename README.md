# Dotfiles

Personal dotfiles and Mac bootstrap configuration for James Aymer. Manages shell, editor, and tool configs across the host Mac and dev containers.

---

## What's in here

| File / Directory | Purpose |
|---|---|
| `.zshrc` | Main Zsh config — works on both Mac and containers |
| `.zshenv` | Zsh environment config |
| `.zprofile` | Zsh profile config |
| `.gitconfig` | Global Git config (personal email) |
| `.gitconfig.work` | Git config override for `~/work/` (work email) |
| `.p10k.zsh` | Powerlevel10k prompt config |
| `.config/nvim/` | Full Neovim config with lazy.nvim plugins |
| `.config/wezterm/wezterm.lua` | WezTerm terminal config |
| `.config/aerospace/aerospace.toml` | Aerospace window manager config |
| `.awsume/config.yaml` | Awsume preferences |
| `install.sh` | Symlinks dotfiles — runs automatically in DevPod containers |
| `bootstrap-mac.sh` | Full Mac setup script — run once on a new machine |

---

## New Mac Setup

This will:
- Install all host tools via Homebrew
- Create the home directory structure
- Symlink all config files to their expected locations


### Install Xcode
```bash
xcode-select --install
```

### Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
After installing, add Homebrew to your PATH (Apple Silicon only):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Clone the dotfiles repo
```bash
git clone https://github.com/semaj87/dotfiles.git ~/dotfiles
```

### Run the bootstrap-mac script
```bash
cd ~/dotfiles
chmod +x bootstrap-mac.sh
./bootstrap-mac.sh
```

### Manual steps after bootstrap

1.  Open JetBrains Toolbox and install **PyCharm Professional**
2.  Open JetBrains Toolbox and install **JetBrains Gateway**
3.  Install Docker Desktop, download from: `docker.com/products/docker-desktop (Apple Silicon version)`
4.  Generate a new SSH key for GitHub access:
     - `ssh-keygen -t ed25519 -C "aymerjames@gmail.com"`
     - `ssh-add ~/.ssh/id_ed25519`
     - `cat ~/.ssh/id_ed25519.pub`
     - Copy the output and add it to GitHub: Settings > SSH and GPG keys > New SSH key
5.  Configure DevPod:
      - Set provider to Podman (Docker provider pointing to `/opt/podman/bin/podman`)
      - Set dotfiles repo to `https://github.com/semaj87/dotfiles.git`
      - Set SSH key path to `~/.ssh/id_ed25519`
      - Set IDE to None
6.  Clone devcontainer templates: `git clone git@github.com:semaj87/devcontainer-templates.git ~/devcontainer-templates`
7.  Download AlmaLinux AArch64 minimal ISO from [almalinux.org](https://almalinux.org) and move to `~/isos/`
8.  Configure UTM — Create a new VM with these exact settings:
      - Click: Create a New Virtual Machine > Virtualize > Linux
      - Boot ISO: select AlmaLinux AArch64 ISO from ~/isos/
      - Enable display output: yes
      - Use Apple Virtualization: no (uses QEMU)
      - Architecture: ARM64 (aarch64)
      - Machine: QEMU 10.0 ARM Virtual Machine (virt)
      - Memory: 2GB
      - Storage: 20GB (recommended)
      - Network: Shared Network (virtio-net-pci)
      - Name the VM: AlmaLinux
      - Boot and install AlmaLinux, then eject the ISO when complete
9.  Install App Store apps: Be Focused Pro, Theine (if desired)
10. Restore sensitive files:
      - Copy ~/.zshrc.local from 1Password to a newly created ~/.zshrc.local
      - Copy ~/.gitconfig.work from 1Password to a newly created ~/.gitconfig.work
      - Copy ~/.local/bin/tools-access/tools-access.sh from 1Password to a newly created ~/.local/bin/tools-access/tools-access.sh
      - Run:  chmod +x ~/.local/bin/tools-access/tools-access.sh
11. Install IB Gateway: Download Apple Silicon version from:
      - `https://www.interactivebrokers.com/en/trading/ibgateway-latest.php`
12. Restore AWS config:
      - Copy ~/.aws/config from 1Password to a newly created ~/.aws/config
      - Copy ~/.aws/credentials from 1Password to a newly created ~/.aws/credentials
13. Apply keyboard settings: Log out and back in for keyboard repeat speed to take effect
      - Apple menu > Log Out > Log back in
14. Configure GitLab access:
      - Go to gitlab.tools.btcsp.co.uk > Preferences > Access Tokens
      - Create token with the appropriate scope level
      - Clone any repo via HTTPS and enter username + token when prompted
      - Git will store credentials automatically for future use
      - `git clone https://gitlab.tools.btcsp.co.uk/org/repo.git ~/work/repo`
15. Restore Zscaler certificate:
      - Copy zscaler-ca.crt from 1Password
      - Copy to each devcontainer template .devcontainer directory:
        - cp ~/Downloads/zscaler-ca.crt ~/devcontainer-templates/python-aws/.devcontainer/
        - cp ~/Downloads/zscaler-ca.crt ~/devcontainer-templates/python/.devcontainer/
        - cp ~/Downloads/zscaler-ca.crt ~/devcontainer-templates/quant-dev/.devcontainer/
        - cp ~/Downloads/zscaler-ca.crt ~/devcontainer-templates/kubernetes/.devcontainer/
        - cp ~/Downloads/zscaler-ca.crt ~/devcontainer-templates/nvim-practice/.devcontainer/
---

## Container Setup

DevPod automatically clones this repo and runs `install.sh` in every new container, which symlinks all config files. Zsh, Neovim, Git, and shell aliases work the same in containers as on the host Mac.

Mac-specific config (oh-my-zsh, zplug, pyenv, Homebrew tools) is guarded with:

```bash
if [[ "$(uname)" == "Darwin" ]]; then
  # Mac only
fi
```

---

## Home Directory Structure

```
~
├── work/                   # Work repos cloned from GitLab
├── personal/               # Personal projects and experiments
├── dotfiles/               # This repo
├── devcontainer-templates/ # DevPod container templates
├── learning/               # Personal learning
├── isos/                   # AlmaLinux ISO backup
└── downloads/              # macOS default
```

---

## Sensitive Config

Sensitive information (AWS account numbers, role ARNs, ECR login aliases) lives in `~/.zshrc.local` which is never committed. The `.zshrc` loads it automatically if it exists:

```bash
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

AWS credentials and config live in `~/.aws/` which is also never committed. On containers, `~/.aws` is mounted read-only from the host Mac via the devcontainer.json mounts config.

---

## Tools Managed by This Repo

### Host Mac
| Tool              | Purpose |
|-------------------|---|
| WezTerm           | Terminal |
| Aerospace         | Tiling window manager |
| Podman Desktop    | Container engine |
| DevPod            | Dev container lifecycle manager |
| Raycast           | App launcher |
| Chrome            | Browser |
| Notion            | Notes |
| JetBrains Toolbox | IDE manager |
| 1Password         | Password manager |
| NordVPN           | VPN |
| Stats             | Menu bar system monitor |
| VirtualBox / UTM  | VM manager for AlmaLinux |

### Inside Containers
| Tool | Purpose |
|---|---|
| Python | Language runtime |
| Poetry | Dependency management |
| AWS CLI | AWS interactions |
| awsume | AWS role assumption |
| Terraform | Infrastructure as code |
| kubectl | Kubernetes CLI |
| k9s | Kubernetes TUI |
| Helm | Kubernetes package manager |
| Neovim | Editor |
| Claude Code | AI coding assistant |
