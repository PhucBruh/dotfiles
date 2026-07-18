#!/usr/bin/env bash
# core.sh — tmux-launcher core library
#
# Provides:
#   tl::fzf            run fzf with theme from config.sh
#   tl::prompt         single-line text input
#   tl::confirm        yes/no confirmation
#   tl::preview::pane  preview tmux pane
#   tl::preview::session preview tmux session
#   tl::preview::tree  preview directory with eza/tree
#   tl::preview::file  preview file with bat/head
#   tl::switch_*       switch to window/session
#   tl::kill_*         safe kill window/session
#   tl::window::open   managed window with auto-close

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

# ── fzf wrappers ───────────────────────────────────────────────────────

tl::fzf() {
    command -v fzf >/dev/null || { echo "fzf not found" >&2; return 1; }
    fzf --layout reverse --ansi --no-mouse \
        --border "$TL_BORDER" --gutter "$TL_GUTTER" \
        --color="border:$TL_BORDER_COLOR,label:$TL_LABEL_COLOR" \
        --info "$TL_INFO" --pointer "$TL_POINTER" \
        --preview-window "$TL_PREVIEW" --preview-label '{1}' \
        --tmux "$TL_POPUP" "$@"
}

tl::prompt() {
    local message="$1" default="${2:-}"
    fzf --layout reverse --print-query --no-mouse \
        --border "$TL_BORDER" --gutter "$TL_GUTTER" \
        --color="border:$TL_BORDER_COLOR,label:$TL_LABEL_COLOR" \
        --pointer "$TL_POINTER" \
        --prompt "$message > " --query "$default" </dev/null | head -n1
}

tl::confirm() {
    local message="$1"
    printf 'No\nYes' | fzf --layout reverse --no-mouse \
        --border "$TL_BORDER" --gutter "$TL_GUTTER" \
        --color="border:$TL_BORDER_COLOR,label:$TL_LABEL_COLOR" \
        --pointer "$TL_POINTER" \
        --border-label " $message " --prompt '> '
}

# ── Preview renderers ──────────────────────────────────────────────────

tl::preview::pane() {
    local target="$1"
    local path cmd
    path="$(tmux display-message -p -t "$target" '#{pane_current_path}' 2>/dev/null)"
    cmd="$(tmux display-message -p -t "$target" '#{pane_current_command}' 2>/dev/null)"
    printf '\033[1mdir:\033[0m  %s\n' "$path"
    printf '\033[1mcmd:\033[0m  %s\n' "$cmd"
    printf -- '---\n'
    tmux capture-pane -e -p -t "$target" 2>/dev/null
}

tl::preview::session() {
    local session="$1"
    tmux list-windows -t "$session" -F '#{window_index}' | while read -r win; do
        local name cmd
        name="$(tmux display-message -p -t "${session}:${win}" '#{window_name}')"
        cmd="$(tmux display-message -p -t "${session}:${win}" '#{pane_current_command}')"
        printf '  %s: %s  (%s)\n' "$win" "$name" "$cmd"
    done
}

tl::preview::tree() {
    local dir="$1"
    if command -v eza >/dev/null; then
        eza --tree --level=2 --color=always --icons --group-directories-first "$dir" 2>/dev/null
    elif command -v tree >/dev/null; then
        tree -L 2 -C "$dir" 2>/dev/null
    else
        find "$dir" -maxdepth 2 2>/dev/null | sed "s|^$dir|.|"
    fi
}

tl::preview::file() {
    local file="$1"
    [ -f "$file" ] || { printf '(no such file: %s)\n' "$file"; return 0; }
    if command -v bat >/dev/null; then
        bat --color=always --style=numbers,changes "$file" 2>/dev/null
    else
        head -n 200 "$file"
    fi
}

# ── Tmux helpers ───────────────────────────────────────────────────────

tl::current_session() { tmux display-message -p '#{session_name}'; }
tl::current_window()  { tmux display-message -p '#{session_name}:#{window_index}'; }
tl::current_path()    { tmux display-message -p '#{pane_current_path}'; }

tl::switch_window()  { tmux switch-client -t "$1" 2>/dev/null || tmux attach-session -t "$1"; }
tl::switch_session() { tl::switch_window "$1"; }

tl::kill_window() {
    local target="$1"
    if [ "$(tl::current_window)" = "$target" ]; then
        tmux next-window -t "${target%%:*}" 2>/dev/null
    fi
    tmux kill-window -t "$target"
}

tl::kill_session() {
    local target="$1"
    if [ "$(tl::current_session)" = "$target" ]; then
        local fallback
        fallback="$(tmux list-sessions -F '#{session_name}' | grep -v "^${target}$" | head -n1)"
        [ -n "$fallback" ] && tmux switch-client -t "$fallback" 2>/dev/null
    fi
    tmux kill-session -t "$target"
}

# ── Managed window ─────────────────────────────────────────────────────

tl::window::open() {
    local name="$1" dir="$2"; shift 2
    local -a cmd=("$@")
    [ -d "$dir" ] || dir="$HOME"

    if tmux select-window -t ":$name" 2>/dev/null; then
        return 0
    fi

    local quoted_cmd
    quoted_cmd="$(printf '%q ' "${cmd[@]}")"
    local wrapper="cd $(printf '%q' "$dir") && { ${quoted_cmd}; }; tmux kill-window -t \"\$TMUX_PANE\" 2>/dev/null || true"

    local window_id
    window_id="$(tmux new-window -P -F '#{window_id}' -n "$name" -c "$dir" "$wrapper")"

    tmux set-option -w -t "$window_id" remain-on-exit off 2>/dev/null

    local hook_idx="${window_id#@}"
    local kill_cmd="run-shell 'tmux kill-window -t $window_id 2>/dev/null; tmux set-hook -gu after-select-window[${hook_idx}]; tmux set-hook -gu client-session-changed[${hook_idx}]'"

    tmux set-hook -g after-select-window[${hook_idx}] \
        "if-shell -F '#{!=:#{window_id},$window_id}' \"$kill_cmd\""

    tmux set-hook -g client-session-changed[${hook_idx}] \
        "if-shell -F '#{!=:#{window_id},$window_id}' \"$kill_cmd\""

    tmux switch-client -t "$window_id" 2>/dev/null
}
