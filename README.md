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

Stows all config dirs via GNU Stow:

| Config | What |
|---|---|
| [`zsh`](zsh/) | zsh, exports, aliases, plugins |
| [`nvim`](nvim/) | Neovim editor config |
| [`ghostty`](ghostty/) | Ghostty terminal emulator |
| [`tmux`](tmux/) | Tmux with tmuxifier, plugins, scripts |
| [`xfce`](xfce/) | XFCE panel, WM, keybindings, GTK CSS |
| [`bat`](bat/) | bat (cat alternative) theme |
| [`starship`](starship/) | Starship prompt |
| [`yazi`](yazi/) | Yazi file manager |
| [`eza`](eza/) | eza (ls alternative) theme |
| [`git`](git/) | Git config and ignore |
| [`herdr`](herdr/) | herdr launcher and modes |
| [`rofi`](rofi/) | Rofi launcher config |

Wallpapers in [`wallpapers/`](wallpapers/) are not stowed.
