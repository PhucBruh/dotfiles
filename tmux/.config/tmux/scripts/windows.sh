#!/usr/bin/env bash
# windows.sh — tmux window picker (prefix f → i)
#
# <CR>:switch  <C-r>:rename  <C-k>:kill

set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

SELF="$(readlink -f "$0")"

case "${1:-}" in
    --preview)
        tl::preview::pane "$2"
        exit 0
        ;;
    --items)
        tmux list-windows -a -F '#{session_name}'$'\t''#{window_index}'$'\t''#{window_name}' \
            | awk -F'\t' '{ printf "%s\t%s:%s %s\n", $1":"$2, $1, $2, $3 }'
        exit 0
        ;;
    --kill)
        id="$2"
        name="$(tmux display-message -p -t "$id" '#{window_name}' 2>/dev/null)"
        ans="$(tl::confirm "Kill window $name?")"
        [ "$ans" = "Yes" ] && tl::kill_window "$id"
        exit 0
        ;;
    --rename)
        id="$2"
        current="$(tmux display-message -p -t "$id" '#{window_name}' 2>/dev/null)"
        new_name="$(tl::prompt "Rename window" "$current")"
        [ -n "$new_name" ] && tmux rename-window -t "$id" "$new_name"
        exit 0
        ;;
esac

line="$("$SELF" --items | tl::fzf \
    --border-label ' Window ' \
    --prompt '> ' \
    --header "<C-r>:rename  <C-k>:kill" \
    --delimiter '\t' --with-nth "2" \
    --preview "'$SELF' --preview {1}" \
    --bind "ctrl-k:execute('$SELF' --kill {1})+reload('$SELF' --items)" \
    --bind "ctrl-r:execute('$SELF' --rename {1})+reload('$SELF' --items)")"

[ -z "$line" ] && exit 0
id="$(cut -f1 <<< "$line")"
tl::switch_window "$id"
