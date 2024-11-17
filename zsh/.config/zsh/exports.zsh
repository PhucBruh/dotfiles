export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH="$HOME/.anaconda3/bin:$PATH"
export PATH=$GOPATH/bin:$PATH
export GOPATH=$HOME/.local/share/go
export PATH="/usr/bin/lua5.1:$PATH"
export BAT_THEME="tokyonight_night"

# export PATH="$HOME/.local/share/pipx/shared/bin:$PATH"
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
