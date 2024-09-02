# exports homebrew environment vars
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# directory for storing zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# use pure theme
zinit ice depth=1
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light conda-incubator/conda-zsh-completion

# add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey -s '^o' ". tmux-fzf\n"

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# aliases
alias ls='ls --color'
alias la='ls -a --color'
alias ll='ls -al --color'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# add completions
command -v kubectl &> /dev/null && source <(kubectl completion zsh)
command -v helm &> /dev/null && source <(helm completion zsh)
command -v minikube &> /dev/null && source <(minikube completion zsh)

# >>> NVM configuration >>>
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # load nvm
  nvm $@ # copy arguments after nvm
}
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # load nvm bash_completion
# <<< NVM configuration <<<

# add paths
export PATH="$HOME/.local/bin:$PATH"                  # add custom binaries
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH" # add mason binaries

# git shortcuts
alias gs="git status"
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"

export TERM="screen-256color"
export LANG="en_US.UTF-8"

DISABLE_AUTO_TITLE="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374,bold"
# Complete suggestion with <C-e>
# Tmux normal mode: <C-a>[ then use vim motions
# Enter visual mode: v or <Space>
# Yank selection: y or <CR>
# Paste: <C-a>]
# Kitty scroll: <C-Shift-up>
# Paste within command mode: <C-r>"

os=$(uname)

# Linux only
if [[ $os == "Linux" ]]; then

    # disable <C-;> behavior
    gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]" || echo "gsettings not found"

    export PYTHONPATH="$HOME/personal/dsa"
    clear

# Mac only
elif [[ $os == "Darwin" ]]; then
    export PYTHONPATH="$HOME/Code/gesture-recognition/src"
    clear
fi
