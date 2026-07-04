#!/bin/bash
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { printf "${GREEN}%s${NC}\n" "$*"; }
step()  { printf "${CYAN}[%d/%d]${NC} %s\n" $1 $2 "$3"; }
err()   { printf "${RED}%s${NC}\n" "$*" >&2; }

TOTAL=7

# ── 1. System packages ──────────────────────────────────────────
step 1 $TOTAL "Installing system packages..."
if command -v apt &>/dev/null; then
  sudo apt update && sudo apt install -y zsh stow git curl unzip
elif command -v pacman &>/dev/null; then
  sudo pacman -S --noconfirm zsh stow git curl unzip
elif command -v dnf &>/dev/null; then
  sudo dnf install -y zsh stow git curl unzip
elif command -v apk &>/dev/null; then
  sudo apk add zsh stow git curl unzip
else
  err "No supported package manager found. Install: zsh, stow, git, curl, unzip"
  exit 1
fi

# ── 2. Rust + cargo-binstall ────────────────────────────────────
step 2 $TOTAL "Installing Rust toolchain..."
if ! command -v cargo &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
. "$HOME/.cargo/env"

step 3 $TOTAL "Installing cargo-binstall..."
cargo install cargo-binstall 2>/dev/null || true

# ── 3. Tools via cargo-binstall ─────────────────────────────────
step 4 $TOTAL "Installing tools via cargo-binstall..."
cargo binstall -y \
  eza bat starship zoxide yazi ripgrep fd-find fzf

# ── 4. Neovim ──────────────────────────────────────────────────
step 5 $TOTAL "Installing Neovim (latest)..."
curl -fL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
  -o /tmp/nvim.tar.gz
tar xzf /tmp/nvim.tar.gz -C /tmp
mkdir -p "$HOME/.local/bin"
cp -f /tmp/nvim-linux-x86_64/bin/nvim "$HOME/.local/bin/nvim"
rm -rf /tmp/nvim-linux-x86_64 /tmp/nvim.tar.gz

# ── 6. oh-my-zsh ────────────────────────────────────────────────
step 6 $TOTAL "Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── 7. Dotfiles ────────────────────────────────────────────────
step 7 $TOTAL "Stowing dotfiles..."
if [ ! -d "$HOME/dotfiles" ]; then
  info "Cloning dotfiles..."
  git clone https://github.com/$(whoami)/dotfiles "$HOME/dotfiles"
fi
cd "$HOME/dotfiles"
for dir in */; do
  dir="${dir%/}"
  stow -R "$dir" 2>/dev/null && info "  ✔ $dir" || err "  ✖ $dir"
done

# ── Done ────────────────────────────────────────────────────────
if command -v zsh &>/dev/null; then
  info "Setting default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

info ""
info "All done! Restart your shell or run: exec zsh"
