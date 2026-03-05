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

Clone this repo and run the bootstrap script:

```bash
git clone https://github.com/semaj87/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap-mac.sh
./bootstrap-mac.sh
```

This will:
- Install all host tools via Homebrew
- Create the home directory structure
- Symlink all config files to their expected locations

### Manual steps after bootstrap

1. Open JetBrains Toolbox and install **PyCharm Professional**
2. Open JetBrains Toolbox and install **JetBrains Gateway**
3. Configure DevPod:
    - Set provider to Podman (Docker provider pointing to `/opt/podman/bin/podman`)
    - Set dotfiles repo to `https://github.com/semaj87/dotfiles.git`
    - Set SSH key path to `~/.ssh/id_ed25519`
    - Set IDE to None
4. Clone devcontainer templates: `git clone https://github.com/semaj87/devcontainer-templates.git ~/devcontainer-templates`
5. Download AlmaLinux AArch64 minimal ISO from [almalinux.org](https://almalinux.org) and move to `~/isos/`
6. Create AlmaLinux VM in UTM using the ISO
7. Install App Store apps: Be Focused Pro, Theine (if desired)

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
| Tool | Purpose |
|---|---|
| WezTerm | Terminal |
| Aerospace | Tiling window manager |
| Podman Desktop | Container engine |
| DevPod | Dev container lifecycle manager |
| Raycast | App launcher |
| Brave | Browser |
| Notion | Notes |
| JetBrains Toolbox | IDE manager |
| 1Password | Password manager |
| NordVPN | VPN |
| Stats | Menu bar system monitor |
| VirtualBox / UTM | VM manager for AlmaLinux |

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
