# Make fzf-tab use FZF_DEFAULT_OPTS (colors + ctrl-j binding)
zstyle ':fzf-tab:*' use-fzf-default-opts yes

export FZF_DEFAULT_OPTS="
  --bind 'ctrl-j:accept'
  --highlight-line
  --info=inline-right
  --ansi
  --layout=reverse
  --border=none
  --color=bg+:#253547
  --color=bg:#16181a
  --color=border:#5ea1ff
  --color=fg:#ffffff
  --color=gutter:#16181a
  --color=header:#bd5eff
  --color=hl+:#5ef1ff
  --color=hl:#5ef1ff
  --color=info:#7b8496
  --color=marker:#ff5ea0
  --color=pointer:#ff5ea0
  --color=prompt:#5ea1ff
  --color=query:#ffffff:regular
  --color=scrollbar:#5ea1ff
  --color=separator:#ffbd5e
  --color=spinner:#ff5ea0
"
