if (( $+commands[eza] )); then
  alias ls='eza --long --group-directories-first --icons'
  alias ll='eza -lah --group-directories-first --icons'
  alias la='eza -a --icons'
  alias tree='eza --tree --icons'
fi

if (( $+commands[batcat] )); then
  alias bat='batcat'
  alias cat='batcat --paging=never'
elif (( $+commands[bat] )); then
  alias cat='bat --paging=never'
fi

alias pvenv='[ -f .venv/bin/activate ] && source .venv/bin/activate || source venv/bin/activate'
alias nv='nvim'
alias leet='nvim leetcode.nvim'

# herdr workflow helpers — type fw/fp/fpa/fdot in any terminal
export PATH="$HOME/.config/herdr/scripts:$PATH"
