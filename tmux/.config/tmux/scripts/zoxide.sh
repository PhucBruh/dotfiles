#!/usr/bin/env bash
# zoxide.sh — zoxide directory picker (prefix f → z)
# Changes directory in the current pane.

set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

command -v zoxide >/dev/null || exit 0

dir="$(zoxide query -l | tl::fzf --border-label ' Zoxide ' --prompt '> ' \
    --preview 'eza --tree --level=2 --color=always --icons --group-directories-first {} 2>/dev/null')"
[ -z "$dir" ] && exit 0

tmux send-keys "cd $(printf '%q' "$dir")" Enter
