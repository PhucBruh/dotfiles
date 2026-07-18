#!/usr/bin/env bash
# sessions.sh — tmux session picker (prefix f → w)
#
# <CR>:switch  <C-r>:rename  <C-k>:kill

set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

SELF="$(readlink -f "$0")"

case "${1:-}" in
    --preview)
        tl::preview::session "$2"
        exit 0
        ;;
    --items)
        tmux list-sessions -F '#{session_name}'
        exit 0
        ;;
    --kill)
        id="$2"
        ans="$(tl::confirm "Kill session $id?")"
        [ "$ans" = "Yes" ] && tl::kill_session "$id"
        exit 0
        ;;
    --rename)
        id="$2"
        new_name="$(tl::prompt "Rename session" "$id")"
        [ -n "$new_name" ] && tmux rename-session -t "$id" "$new_name"
        exit 0
        ;;
esac

line="$("$SELF" --items | tl::fzf \
    --border-label ' Session ' \
    --prompt '> ' \
    --header "<C-r>:rename  <C-k>:kill" \
    --preview "'$SELF' --preview {1}" \
    --bind "ctrl-k:execute('$SELF' --kill {1})+reload('$SELF' --items)" \
    --bind "ctrl-r:execute('$SELF' --rename {1})+reload('$SELF' --items)")"

[ -z "$line" ] && exit 0
id="$(cut -f1 <<< "$line")"
tl::switch_session "$id"
