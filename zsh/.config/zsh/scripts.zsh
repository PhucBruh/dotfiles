# Stow all the config in stow ~/.dotfiles
stowa() {
  stow -d ~/.dotfiles \
    kitty \
    nvim \
    starship \
    tmux \
    zsh \
    kanata \
}
