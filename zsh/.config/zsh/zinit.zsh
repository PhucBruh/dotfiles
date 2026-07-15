ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"
unalias zi

plugins=(
  zsh-users/zsh-autosuggestions 
  zsh-users/zsh-syntax-highlighting 
  Aloxaf/fzf-tab 
  zsh-users/zsh-history-substring-search
  jeffreytse/zsh-vi-mode
)

for pkg in $plugins; do
  zinit ice depth=1
  zinit light "$pkg"
done
