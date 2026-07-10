#!/usr/bin/env bash
# windows.sh — window picker (prefix f i)
#
# enter:switch  ctrl-r:rename  ctrl-k:kill
set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

SELF="$(readlink -f "$0")"

case "${1:-}" in
    --preview)
        tl::preview::pane "$2"
        exit 0
        ;;
    --items)
        tmux list-windows -a -F \
            '#{session_name}	#{window_index}	#{window_name}' \
        | awk -F'\t' '{
            id = $1 ":" $2
            printf "%s\t%s:%s %s\n", id, $1, $2, $3
        }'
        exit 0
        ;;
    --kill)
        id="$2"
        name="$(tmux display-message -p -t "$id" '#{window_name}' 2>/dev/null)"
        printf '\033[1mKill window \033[31m%s\033[0m? [y/N] ' "$name"
        read -r -n1 ans; echo
        [[ "$ans" =~ ^[yY]$ ]] && tl::kill_window "$id"
        exit 0
        ;;
    --rename)
        id="$2"
        current="$(tmux display-message -p -t "$id" '#{window_name}' 2>/dev/null)"
        printf '\033[1mRename window:\033[0m '
        read -r -e -i "$current" new_name
        [ -n "$new_name" ] && tmux rename-window -t "$id" "$new_name"
        exit 0
        ;;
esac

line="$("$SELF" --items | tl::fzf \
    --border-label ' Windows ' \
    --prompt "Windows > " \
    --header "enter:switch  ctrl-r:rename  ctrl-k:kill" \
    --with-nth "2" \
    --preview "'$SELF' --preview {1}" \
    --bind "ctrl-k:execute('$SELF' --kill {1})+reload('$SELF' --items)" \
    --bind "ctrl-r:execute('$SELF' --rename {1})+reload('$SELF' --items)")"

[ -z "$line" ] && exit 0
id="$(cut -f1 <<< "$line")"
tl::switch_window "$id"
