if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"

  zi() {
    local dir
    dir="$(zoxide query -l | fzf \
      --border sharp --gutter ' ' \
      --info right --pointer '▌' \
      --preview-window 'right,60%,border-line' \
      --preview 'eza --tree --level=2 --color=always --icons --group-directories-first {} 2>/dev/null' \
      --prompt '> ')"
    [ -z "$dir" ] && return
    cd "$dir"
  }
fi
