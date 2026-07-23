#!/usr/bin/env bash
# layouts.sh — tmuxp layout picker (prefix f → l)
#
# <C-w>:load with project dir

set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

command -v tmuxp >/dev/null || exit 1
LAYOUT_DIR="$HOME/.config/tmux/layouts"

SELF="$(readlink -f "$0")"

if [ "${1:-}" = "--preview" ]; then
    path="$LAYOUT_DIR/${2}.yaml"
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
        | tl::fzf --border-label ' Project ' --prompt '> '
    )"
    [ -z "$dir" ] && return 1
    case "$dir" in
        /*) printf '%s\n' "$dir" ;;
        *)  printf '%s\n' "$HOME/$dir" ;;
    esac
}

items() {
    for f in "$LAYOUT_DIR"/*.yaml; do
        [ -f "$f" ] || continue
        basename "$f" .yaml
    done
}

while true; do
    result="$(items | tl::fzf \
        --border-label ' Layout ' \
        --prompt '> ' \
        --header "<C-w>:load dir" \
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
            PROJECT_DIR="$project_dir" tmuxp load -y "$LAYOUT_DIR/$name.yaml"
            exit 0
            ;;
        *)
            PROJECT_DIR="$(tl::current_path)" tmuxp load -y "$LAYOUT_DIR/$name.yaml"
            exit 0
            ;;
    esac
done
