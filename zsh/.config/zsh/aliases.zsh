if (( $+commands[eza] )); then
  alias ls='eza --long --group-directories-first --icons'
  alias ll='eza -lah --group-directories-first --icons'
  alias la='eza -a --icons'
  alias tree='eza --tree --icons'
fi

alias pvenv='[ -f .venv/bin/activate ] && source .venv/bin/activate || source venv/bin/activate'

alias nv='nvim'

alias zksync='cd $ZK_NOTEBOOK_DIR && git add . && git commit -m "update $(date +%Y-%m-%d)" && git push origin main'
