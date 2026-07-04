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
git clone https://github.com/$(whoami)/dotfiles ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## What it installs

| Tool | Source |
|---|---|
| zsh, stow, git, curl | System package manager |
| Rust + cargo-binstall | rustup.sh |
| eza, bat, starship, zoxide, yazi, ripgrep, fd-find, fzf | cargo-binstall (prebuilt) |
| nvim | Official tarball |
| oh-my-zsh | Install script |

## Manual setup per machine

- **Nerd Font** — download from [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) for icons in eza/yazi/starship
- **Git identity** — update `~/.gitconfig` with your name/email if needed
