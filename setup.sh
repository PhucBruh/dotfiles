#!/bin/bash
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { printf "${GREEN}%s${NC}\n" "$*"; }
step()  { printf "${CYAN}[%d/%d]${NC} %s\n" $1 $2 "$3"; }
err()   { printf "${RED}%s${NC}\n" "$*" >&2; }

TOTAL=8

# ── 1. System packages ──────────────────────────────────────────
step 1 $TOTAL "Installing system packages..."
PKGS="zsh stow git curl unzip fzf"
if command -v apt &>/dev/null; then
  sudo apt update && sudo apt install -y $PKGS
elif command -v pacman &>/dev/null; then
  sudo pacman -S --noconfirm $PKGS
elif command -v dnf &>/dev/null; then
  sudo dnf install -y $PKGS
elif command -v apk &>/dev/null; then
  sudo apk add $PKGS
else
  err "No supported package manager found. Install: $PKGS"
  exit 1
fi

# ── 2. Rust + cargo-binstall ────────────────────────────────────
step 2 $TOTAL "Installing Rust toolchain..."
if ! command -v cargo &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
. "$HOME/.cargo/env"

step 3 $TOTAL "Installing cargo-binstall..."
if ! command -v cargo-binstall &>/dev/null; then
  curl -L --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
    | bash
fi

# ── 3. Tools via cargo-binstall ────────────────────────────────
step 4 $TOTAL "Installing tools via cargo-binstall..."
cargo binstall -y \
  eza bat starship zoxide ripgrep fd-find git-delta yazi-fm

# ── 4. Neovim ──────────────────────────────────────────────────
step 5 $TOTAL "Installing Neovim (latest)..."
curl -fL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
  -o /tmp/nvim.tar.gz
tar xzf /tmp/nvim.tar.gz -C /tmp
mkdir -p "$HOME/.local/bin"
cp -f /tmp/nvim-linux-x86_64/bin/nvim "$HOME/.local/bin/nvim"
rm -rf /tmp/nvim-linux-x86_64 /tmp/nvim.tar.gz

# ── 5. herdr ───────────────────────────────────────────────────
step 6 $TOTAL "Installing herdr..."
if ! command -v herdr &>/dev/null; then
  curl -fsSL https://herdr.dev/install.sh | sh
fi

# ── 6. oh-my-zsh ───────────────────────────────────────────────
step 7 $TOTAL "Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── 7. Dotfiles ───────────────────────────────────────────────
step 8 $TOTAL "Stowing dotfiles..."
cd "$(dirname "$0")"
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
