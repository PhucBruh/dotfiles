# dotfiles

## Quick start

```bash
# 1. Install Nix (multi-user daemon)
curl -L https://nixos.org/nix/install | sh -s -- --daemon

# 2. Logout/login
# hoặc restart shell

# 3. Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# 4. Clone dotfiles
git clone https://github.com/PhucBruh/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 5. Activate Home Manager from your flake
nix run home-manager/release-26.05 -- switch --flake ./home-manager

# 6. Done
```

## Update packages

```bash
home-manager switch
```

## setup.sh

Stows all config dirs via GNU Stow:

| Config | What |
|---|---|
| [`zsh`](zsh/) | zsh, exports, aliases, plugins |
| [`nvim`](nvim/) | Neovim editor config |
| [`ghostty`](ghostty/) | Ghostty terminal emulator |
| [`tmux`](tmux/) | Tmux with tmuxifier, plugins, scripts |
| [`bat`](bat/) | bat (cat alternative) theme |
| [`starship`](starship/) | Starship prompt |
| [`yazi`](yazi/) | Yazi file manager |
| [`eza`](eza/) | eza (ls alternative) theme |
| [`git`](git/) | Git config and ignore |
| [`rofi`](rofi/) | Rofi launcher config |
| [`lazygit`](lazygit/) | lazygit config |

Wallpapers in [`wallpapers/`](wallpapers/) are not stowed.
