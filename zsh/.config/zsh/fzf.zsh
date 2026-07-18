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
  --color=bg+:#292e42
  --color=bg:#16161e
  --color=border:#89b4fa
  --color=fg:#c0caf5
  --color=gutter:#16161e
  --color=header:#bd5eff
  --color=hl+:#7dcfff
  --color=hl:#7dcfff
  --color=info:#565f89
  --color=marker:#ff5ea0
  --color=pointer:#ff5ea0
  --color=prompt:#89b4fa
  --color=query:#c0caf5:regular
  --color=scrollbar:#89b4fa
  --color=separator:#ffbd5e
  --color=spinner:#ff5ea0
  --color=label:#7dcfff
"
