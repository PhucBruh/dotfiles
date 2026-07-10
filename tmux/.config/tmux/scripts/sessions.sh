#!/usr/bin/env bash
# sessions.sh — session picker (prefix f w)
#
# enter:switch  ctrl-r:rename  ctrl-k:kill
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
        printf '\033[1mKill session \033[31m%s\033[0m? [y/N] ' "$id"
        read -r -n1 ans; echo
        [[ "$ans" =~ ^[yY]$ ]] && tl::kill_session "$id"
        exit 0
        ;;
    --rename)
        id="$2"
        printf '\033[1mRename session:\033[0m '
        read -r -e -i "$id" new_name
        [ -n "$new_name" ] && tmux rename-session -t "$id" "$new_name"
        exit 0
        ;;
esac

line="$("$SELF" --items | tl::fzf \
    --border-label ' Sessions ' \
    --prompt "Sessions > " \
    --header "enter:switch  ctrl-r:rename  ctrl-k:kill" \
    --preview "'$SELF' --preview {1}" \
    --bind "ctrl-k:execute('$SELF' --kill {1})+reload('$SELF' --items)" \
    --bind "ctrl-r:execute('$SELF' --rename {1})+reload('$SELF' --items)")"

[ -z "$line" ] && exit 0
id="$(cut -f1 <<< "$line")"
tl::switch_session "$id"
