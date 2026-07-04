export XDG_CONFIG_HOME="$HOME/.config"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim

export NVM_DIR="$HOME/.config/nvm"

export SDKMAN_DIR="$HOME/.sdkman"

# export EDITOR='nvim'
# export VISUAL='nvim'

export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

export GOROOT="$HOME/.local/share/go"
export PATH="$GOROOT/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
