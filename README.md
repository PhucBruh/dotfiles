# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

| What | Why |
|---|---|
| **sudo access** | Installing system packages |
| **git** | Cloning the repo |
| **curl** | Downloading installers |

## Quick start

```bash
git clone https://github.com/PhucBruh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## What it installs

| Tool | Source |
|---|---|
| zsh, stow, git, curl | System package manager |
| Rust + cargo-binstall | rustup.sh |
| eza, bat, starship, zoxide, yazi, ripgrep, fd-find, fzf, delta | cargo-binstall (prebuilt) |
| nvim | Official tarball |
| herdr | Install script |
| oh-my-zsh | Install script |

## Manual setup per machine

- **Nerd Font** — `curl -fL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.zip -o /tmp/Iosevka.zip && unzip -o /tmp/Iosevka.zip -d ~/.local/share/fonts && fc-cache -f`
- **Git identity** — update `~/.gitconfig` with your name/email if needed
