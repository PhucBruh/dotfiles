#!/bin/sh
# Generic TUI app launcher — opens app in a temp window, auto-closes on focus leave.
# If the window is already open, just focus it instead of spawning a duplicate.
# Usage: open-app.sh <window-name> <command> [working-dir]

NAME="$1"
CMD="$2"
DIR="${3:-$HOME}"

# If the window already exists, just focus it
if tmux select-window -t ":$NAME" 2>/dev/null; then
  exit 0
fi

# Create the window and switch to it
tmux new-window -d -c "$DIR" -n "$NAME" "$CMD"
tmux select-window -t ":$NAME"

# Hook: auto-close this window when focus leaves it.
# Uses run-shell so kill-window errors are suppressed when the window is already gone (app quit normally).
tmux set-hook -g after-select-window \
  "if-shell -F '#{!=:#{window_name},$NAME}' \
    'run-shell \"tmux kill-window -t :$NAME 2>/dev/null; tmux set-hook -gu after-select-window\"'"
