# History
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Load exports & fzf config first
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/bindings.zsh" 

# Load zinit
source "$ZDOTDIR/zinit.zsh"

# Load modules
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/init.zsh"
