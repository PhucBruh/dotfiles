# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

#####################
# PROMPT            #
#####################
zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
zinit load starship/starship

zinit ice atinit"
        ZSH_TMUX_FIXTERM=true;
        ZSH_TMUX_AUTOSTART=true;
        ZSH_TMUX_AUTOCONNECT=true;" 

#  Ensure having tmux.extra.conf from omz plugin
if [[ ! -f ${ZINIT_HOME}/../snippets/OMZP::tmux/tmux.extra.conf ]]; then
  mkdir -p ${ZINIT_HOME}/../snippets/OMZP::tmux
  curl -o ${ZINIT_HOME}/../snippets/OMZP::tmux/tmux.extra.conf https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/tmux/tmux.extra.conf
fi
zinit snippet OMZP::tmux

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit ice atinit"
        ZSH_TMUX_FIXTERM=true;
        ZSH_TMUX_AUTOSTART=true;
        ZSH_TMUX_AUTOCONNECT=true;"

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export FZF_DEFAULT_OPTS='
--bind "ctrl-j:accept"
--bind "ctrl-k:abort"
'

# History
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

source ~/.config/zsh/exports.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/scripts.zsh

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"