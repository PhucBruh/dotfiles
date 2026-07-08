#!/usr/bin/env bash
# Session picker — switch, kill, or rename tmux sessions.
script_dir="$(cd "$(dirname "$0")" && pwd)"
. "$script_dir/lib/picker.sh"

handle_select() {
  [ -z "$1" ] && return
  tmux_cmd switch-client -t "$1"
}

handle_kill() {
  [ -z "$1" ] && return
  confirm "Kill session '$1'?" || return

  local current
  current=$(tmux_cmd display-message -p '#S' 2>/dev/null)
  if [ "$1" = "$current" ]; then
    local nearest
    nearest=$(tmux_cmd list-sessions -F '#{session_name}' 2>/dev/null \
      | grep -v "^$1$" | sort | head -1)
    [ -n "$nearest" ] && tmux_cmd switch-client -t "$nearest"
  fi
  tmux_cmd kill-session -t "$1"
}

handle_rename() {
  [ -z "$1" ] && return
  local newname; newname=$(prompt "Rename to: ")
  [ -n "$newname" ] && tmux_cmd rename-session -t "$1" "$newname"
}

picker \
  --name      "session" \
  --source    'tmux_cmd list-sessions -F "#{session_name}" 2>/dev/null' \
  --on-select handle_select \
  --on-kill   handle_kill \
  --on-rename handle_rename
