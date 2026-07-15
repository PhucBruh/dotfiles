function zvm_after_init() {
  # Restore autosuggestions accept key
  bindkey -M viins '^E' autosuggest-accept
}

# Alt+r — zoxide interactive
bindkey -s '\er' 'zi\n'
