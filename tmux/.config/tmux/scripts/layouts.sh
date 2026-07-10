#!/usr/bin/env bash
# layouts.sh — tmuxifier layout picker (prefix f l)
#
# enter:load  ctrl-w:load with project dir
set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

TMUXIFIER_BIN="$HOME/.tmux/plugins/tmuxifier/bin/tmuxifier"
[ -x "$TMUXIFIER_BIN" ] || exit 1
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts"

SELF="$(readlink -f "$0")"

if [ "${1:-}" = "--preview" ]; then
    path="$TMUXIFIER_LAYOUT_PATH/${2}.session.sh"
    [ -f "$path" ] && tl::preview::file "$path" || echo "(unknown)"
    exit 0
fi

WORKSPACES=("$HOME/Workspaces/" "$HOME/Development/")

pick_project_dir() {
    local dir
    dir="$(
        for ws in "${WORKSPACES[@]}"; do
            [ -d "$ws" ] && find "$ws" -name .git -type d -prune 2>/dev/null | sed 's|/\.git$||'
        done \
        | sed "s|^$HOME/||" \
        | sort -u \
        | tl::fzf --border-label ' Project ' --prompt "Project dir > "
    )"
    [ -z "$dir" ] && return 1
    case "$dir" in
        /*) printf '%s\n' "$dir" ;;
        *)  printf '%s\n' "$HOME/$dir" ;;
    esac
}

while true; do
    result="$("$TMUXIFIER_BIN" list-sessions 2>/dev/null | tl::fzf \
        --border-label ' Layouts ' \
        --prompt "Layouts > " \
        --header "enter:load  ctrl-w:load with project dir" \
        --expect "enter,ctrl-w" \
        --preview "'$SELF' --preview {1}")"

    [ -z "$result" ] && exit 0

    key="$(head -n1 <<< "$result")"
    name="$(tail -n+2 <<< "$result")"
    [ -z "$name" ] && exit 0

    case "$key" in
        ctrl-w)
            project_dir="$(pick_project_dir)"
            [ -z "$project_dir" ] && continue
            PROJECT_DIR="$project_dir" "$TMUXIFIER_BIN" load-session "$name"
            exit 0
            ;;
        *)
            PROJECT_DIR="$(tl::current_path)" "$TMUXIFIER_BIN" load-session "$name"
            exit 0
            ;;
    esac
done
