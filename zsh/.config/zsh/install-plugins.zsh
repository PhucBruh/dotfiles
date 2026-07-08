() {
  local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  mkdir -p "$plugin_dir"

  local -A plugins=(
    zsh-autosuggestions           https://github.com/zsh-users/zsh-autosuggestions.git
    zsh-syntax-highlighting       https://github.com/zsh-users/zsh-syntax-highlighting.git
    fzf-tab                       https://github.com/Aloxaf/fzf-tab.git
    zsh-history-substring-search  https://github.com/zsh-users/zsh-history-substring-search.git
  )

  local name dir
  for name in "${(@k)plugins}"; do
    dir="$plugin_dir/$name"
    if [[ ! -d "$dir" ]]; then
      print "[zsh] Installing plugin: $name"
      command git clone --depth=1 "$plugins[$name]" "$dir"
    fi
  done
}
