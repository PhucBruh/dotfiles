# Make fzf-tab use FZF_DEFAULT_OPTS (colors + ctrl-j binding)
zstyle ':fzf-tab:*' use-fzf-default-opts yes

eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="
  --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' 
  --bind 'ctrl-j:accept'
  --highlight-line
  --info=inline-right
  --ansi
  --layout=reverse
  --color=bg+:#292E42
  --color=bg:#16161E
  --color=border:#7AA2F7
  --color=fg:#C0CAF5
  --color=gutter:#16161E
  --color=header:#bd5eff
  --color=hl+:#5ef1ff
  --color=hl:#5ef1ff
  --color=info:#7b8496
  --color=marker:#ff5ea0
  --color=pointer:#ff5ea0
  --color=prompt:#7AA2F7
  --color=query:#C0CAF5:regular
  --color=scrollbar:#7AA2F7
  --color=separator:#ffbd5e
  --color=spinner:#ff5ea0
  --color=label:#5ef1ff
"
