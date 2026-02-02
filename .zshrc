# exports homebrew environment vars
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# directory for storing zinit and plugins
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

# download zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# use pure theme with modified colors
zinit ice depth=1
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zstyle ':prompt:pure:prompt:success' color 7
zstyle ':prompt:pure:prompt:error' color 1
zstyle ':prompt:pure:path' color 3
zstyle ':prompt:pure:git:branch' color 7
zstyle ':prompt:pure:git:dirty' color 7

# modify zsh-syntax-highlighting colors
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'

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
# autoload -Uz compinit && compinit -C
#
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zinit cdreplay -q

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey -s '^o' " . tmux-fzf\n"

# history
HISTCONTROL=ignorespace
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

# add paths
export PATH="$HOME/.local/bin:$PATH"                  # add custom binaries
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH" # add mason binaries

# aliases
alias ls='ls --color'
alias la='ls -a --color'
alias ll='ls -al --color'

alias gs="git status"
alias gl="git log"
alias gb="git switch \$(git branch | fzf)"

alias nvm="/usr/local/bin/n"
alias n="nvim"
alias nf="nvim -c ':Telescope find_files'"
alias nd="nvim -c ':Oil'"

export TERM="screen-256color"
export LANG="en_US.UTF-8"
export EDITOR="nvim"

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

    export SHELL="/usr/bin/zsh"

    # disable <C-;> behavior
    command -v gsettings &> /dev/null && gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]" &> /dev/null

    export PYTHONPATH="$HOME/personal/dsa"
    clear

# Mac only
elif [[ $os == "Darwin" ]]; then
    export SHELL="/opt/homebrew/bin/zsh"
    clear
fi

[ -f ~/.zsh_local ] && source ~/.zsh_local || true
