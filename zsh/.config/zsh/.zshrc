export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    git
    sudo
    fzf
    tmux
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
    zsh-history-substring-search
)

DISABLE_AUTO_UPDATE=true
DISABLE_FZF_AUTO_COMPLETION=true

COMPLETION_WAITING_DOTS="true"

# History
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY
HIST_STAMPS="yyyy-mm-dd"

# Load exports & fzf config first (before OMZ)
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/install-plugins.zsh"

# Load OMZ
source "$ZSH/oh-my-zsh.sh"

# Load modules
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/bindings.zsh"
source "$ZDOTDIR/init.zsh"
