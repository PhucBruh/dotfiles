# dotfiles

## Quick start

```bash
git clone https://github.com/PhucBruh/dotfiles.git ~/dotfiles
cd ~/dotfiles

./install.sh   # install tools (run once)
./setup.sh     # stow configs (run anytime)
```

## install.sh

Installs tools:

| Source | Tools |
|---|---|
| system pkm | zsh, stow, git, curl, unzip |
| GitHub release | fzf |
| rustup | Rust + cargo-binstall |
| cargo binstall | eza, bat, starship, zoxide, ripgrep, fd-find, git-delta, yazi-fm |
| tarball | nvim |
| install script | herdr, oh-my-zsh |

## setup.sh

Stows all config dirs via GNU Stow.
