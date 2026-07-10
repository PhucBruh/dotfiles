#!/usr/bin/env bash
# core.sh — shared API for tmux-launcher
#
# Source this from any picker or app script. Provides:
#   tl::fzf           — run fzf with standard options
#   tl::prompt        — single-line fzf input prompt
#   tl::preview::*    — preview renderers (pane, session, tree, file)
#   tl::switch_*      — switch to window/session
#   tl::kill_*        — safe kill window/session
#   tl::window::open  — managed window with auto-close on focus-out

set -uo pipefail

# ── fzf ───────────────────────────────────────────────────────────────

# tl::fzf [fzf-args...]
#   Reads candidates on stdin, writes "key\nselected" to stdout.
#   Always uses: reverse layout, ansi, tab delimiter, no mouse.
tl::fzf() {
    command -v fzf >/dev/null || { echo "fzf not found" >&2; return 1; }
    fzf --layout reverse --ansi --delimiter $'\t' --no-mouse \
        --border sharp --color=border:#7aa2f7 \
        --preview-window 'up,60%,border-none' --preview-label '{1}' \
        --tmux '80%,90%' "$@"
}

# tl::prompt <message> [default]
#   Single-line input prompt via fzf. Returns the typed text.
tl::prompt() {
    local message="$1" default="${2:-}"
    fzf --layout reverse --print-query \
        --prompt "$message: " --header "Press enter to confirm" \
        --query "$default" </dev/null | head -n1
}

# ── Preview ───────────────────────────────────────────────────────────

# tl::preview::pane <session:window>
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

# tl::preview::session <session>
tl::preview::session() {
    local session="$1"
    printf '\033[1msession:\033[0m %s\n' "$session"
    printf -- '---\n'
    tmux list-windows -t "$session" -F '  #{window_index}: #{window_name}  (#{pane_current_command})'
    printf -- '---\n'
    local win
    win="$(tmux display-message -p -t "$session" '#{window_index}' 2>/dev/null)"
    tmux capture-pane -e -p -t "${session}:${win}" 2>/dev/null
}

# tl::preview::tree <directory>
tl::preview::tree() {
    local dir="$1"
    if command -v eza >/dev/null; then
        eza --tree --level=2 --color=always "$dir" 2>/dev/null
    elif command -v tree >/dev/null; then
        tree -L 2 -C "$dir" 2>/dev/null
    else
        find "$dir" -maxdepth 2 2>/dev/null | sed "s|^$dir|.|"
    fi
}

# tl::preview::file <path>
tl::preview::file() {
    local file="$1"
    [ -f "$file" ] || { printf '(no such file: %s)\n' "$file"; return 0; }
    if command -v bat >/dev/null; then
        bat --style=numbers --color=always --line-range=:200 "$file" 2>/dev/null
    else
        head -n 200 "$file"
    fi
}

# ── Tmux helpers ──────────────────────────────────────────────────────

tl::current_session() { tmux display-message -p '#{session_name}'; }
tl::current_window()  { tmux display-message -p '#{session_name}:#{window_index}'; }
tl::current_path()    { tmux display-message -p '#{pane_current_path}'; }

tl::switch_window()  { tmux switch-client -t "$1" 2>/dev/null || tmux attach-session -t "$1"; }
tl::switch_session() { tl::switch_window "$1"; }

# tl::kill_window <session:window>
#   Move client away first if it's the active window, then kill.
tl::kill_window() {
    local target="$1"
    if [ "$(tl::current_window)" = "$target" ]; then
        tmux next-window -t "${target%%:*}" 2>/dev/null
    fi
    tmux kill-window -t "$target"
}

# tl::kill_session <session>
tl::kill_session() {
    local target="$1"
    if [ "$(tl::current_session)" = "$target" ]; then
        local fallback
        fallback="$(tmux list-sessions -F '#{session_name}' | grep -v "^${target}$" | head -n1)"
        [ -n "$fallback" ] && tmux switch-client -t "$fallback" 2>/dev/null
    fi
    tmux kill-session -t "$target"
}

# ── Managed window ────────────────────────────────────────────────────

# tl::window::open <name> <directory> <command...>
#   Creates a tmux window, runs <command>, auto-destroys on exit.
#   Also auto-closes when the user switches away (pane-focus-out hook).
tl::window::open() {
    local name="$1" dir="$2"; shift 2
    local -a cmd=("$@")
    [ -d "$dir" ] || dir="$HOME"

    # Focus if the window already exists instead of spawning a new one
    if tmux select-window -t ":$name" 2>/dev/null; then
        return 0
    fi

    # Build wrapper: run the app, then kill this window on exit
    local quoted_cmd
    quoted_cmd="$(printf '%q ' "${cmd[@]}")"
    local wrapper="cd $(printf '%q' "$dir") && { ${quoted_cmd}; }; tmux kill-window -t \"\$TMUX_PANE\" 2>/dev/null || true"

    local window_id
    window_id="$(tmux new-window -P -F '#{window_id}' -n "$name" -c "$dir" "$wrapper")"

    # Don't linger if remain-on-exit is set globally
    tmux set-option -w -t "$window_id" remain-on-exit off 2>/dev/null

    # Auto-close when user switches away from this window (behave like a popup)
    # We use after-select-window and client-session-changed so it triggers on any switch.
    # Tmux requires hook array indices to be integers, so we use the window ID number.
    local hook_idx="${window_id#@}"
    local kill_cmd="run-shell 'tmux kill-window -t $window_id 2>/dev/null; tmux set-hook -gu after-select-window[${hook_idx}]; tmux set-hook -gu client-session-changed[${hook_idx}]'"
    
    tmux set-hook -g after-select-window[${hook_idx}] \
        "if-shell -F '#{!=:#{window_id},$window_id}' \"$kill_cmd\""
        
    tmux set-hook -g client-session-changed[${hook_idx}] \
        "if-shell -F '#{!=:#{window_id},$window_id}' \"$kill_cmd\""

    tmux switch-client -t "$window_id" 2>/dev/null
}
