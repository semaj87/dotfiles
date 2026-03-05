# =============================================================================
# POWERLEVEL10K INSTANT PROMPT — Mac only
# Must stay at the top of .zshrc
# =============================================================================
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ "$(uname)" == "Darwin" ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi


# =============================================================================
# PATHS
# =============================================================================
export PATH=$HOME/.local/bin:$PATH

if [[ "$(uname)" == "Darwin" ]]; then
  export optflags="-Wno-error=implicit-function-declaration"
  export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
  export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /opt/homebrew/opt/zlib/lib/pkgconfig"
  export DOCKER_HOST="unix:///var/folders/2j/kpsqgpd51630nnv5wl64glph0000gn/T/podman/podman-machine-default-api.sock"
fi


# =============================================================================
# OH MY ZSH
# =============================================================================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/sudo/sudo.plugin.zsh
source $ZSH/plugins/web-search/web-search.plugin.zsh
source $ZSH/plugins/copyfile/copyfile.plugin.zsh
source $ZSH/plugins/history/history.plugin.zsh
source $ZSH/plugins/jsontools/jsontools.plugin.zsh
zstyle ':omz:update' mode reminder


# =============================================================================
# ZPLUG PLUGINS — Mac only
# =============================================================================
if [[ "$(uname)" == "Darwin" ]]; then
  export ZPLUG=$HOME/.zplug
  source $ZPLUG/init.zsh
  source $ZPLUG/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $ZPLUG/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $ZPLUG/repos/zsh-users/zsh-completions/zsh-completions.plugin.zsh
  source $ZPLUG/repos/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh
  zplug "dracula/zsh", as:theme
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-history-substring-search", defer:3
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug load
else
  # Load plugins via oh-my-zsh custom plugins in containers
  plugins=(zsh-syntax-highlighting zsh-autosuggestions zsh-completions zsh-history-substring-search)
fi


# =============================================================================
# PYENV — Mac only
# =============================================================================
if [[ "$(uname)" == "Darwin" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  export PROMPT='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }'"$PROMPT"
fi


# =============================================================================
# ALIASES — SYSTEM
# =============================================================================
alias home='cd ~'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias envcheck='echo "Python: $(which python)"; echo "Version: $(python --version)"; echo "Virtual env: ${VIRTUAL_ENV:-None}"'

if [[ "$(uname)" == "Darwin" ]]; then
  alias ls="eza --icons=always"
  alias brewupdate='brew_update_and_upgrade'
  alias pipeline='sh /Volumes/JHDD/Cloudystuff/Repos/task-runner/bin/pipeline.sh'
  alias drive='/Volumes/JHDD'
  alias bt='/Volumes/JHDD/Cloudystuff/Repos'
  alias ldocker='lazydocker'
  alias listplugins=what_plugins_are_installed_on_my_mac
  alias poetrystartenv='source $(poetry env info --path)/bin/activate'
fi


# =============================================================================
# ALIASES — AWS
# =============================================================================
alias awsume=". awsume"
if [[ "$(uname)" == "Darwin" ]]; then
  alias awsume="source \$(pyenv which awsume)"
fi
alias listprofiles='awsume --list-profiles'
alias ec2-list='aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, Tags[?Key=='\''Name'\'']|[0].Value]" --output table'
alias ec2-connect='aws ssm start-session --target'


# =============================================================================
# ALIASES — KUBERNETES
# =============================================================================
alias kctl='kubectl'


# =============================================================================
# ALIASES — VIRTUALBOX — Mac only
# =============================================================================
if [[ "$(uname)" == "Darwin" ]]; then
  alias almalinux-start='VBoxManage startvm "AlmaLinux" --type headless'
  alias almalinux-stop='VBoxManage controlvm "AlmaLinux" acpipowerbutton'
fi


# =============================================================================
# FUNCTIONS
# =============================================================================
brew_update_and_upgrade() {
    brew update && brew upgrade
}

if [[ "$(uname)" == "Darwin" ]]; then
  what_plugins_are_installed_on_my_mac() {
      echo "\n"
      zplug_plugins
      echo "\n"
      zsh_plugins
      echo "\n"
  }

  zplug_plugins() {
      echo -e "**zplug-plugins**"
      zplug list
  }

  zsh_plugins() {
      echo -e "**zsh-plugins**"
      echo "sudo, web-search, copyfile, history, jsontools"
  }
fi


# =============================================================================
# POWERLEVEL10K — load last, Mac only
# =============================================================================
if [[ "$(uname)" == "Darwin" ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi


# =============================================================================
# LOCAL/PRIVATE CONFIG — load last (never committed to git)
# =============================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
