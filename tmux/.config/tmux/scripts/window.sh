#!/usr/bin/env bash
# Window picker — switch, kill, or rename tmux windows.
script_dir="$(cd "$(dirname "$0")" && pwd)"
. "$script_dir/lib/picker.sh"

target_of() { echo "$1" | awk '{print $1}'; }

handle_select() {
  local target; target=$(target_of "$1")
  [ -z "$target" ] && return
  tmux_cmd select-window -t "$target"
}

handle_kill() {
  local target; target=$(target_of "$1")
  [ -z "$target" ] && return
  confirm "Kill $target?" || return

  local current
  current=$(tmux_cmd display-message -p '#S:#I' 2>/dev/null)
  if [ "$target" = "$current" ]; then
    local session="${target%%:*}"
    local idx="${target##*:}"
    local nearest
    nearest=$(tmux_cmd list-windows -t "$session" -F '#{window_index}' 2>/dev/null \
      | grep -v "^$idx$" | sort -n | head -1)
    [ -n "$nearest" ] && tmux_cmd select-window -t "$session:$nearest"
  fi
  tmux_cmd kill-window -t "$target"
}

handle_rename() {
  local target; target=$(target_of "$1")
  [ -z "$target" ] && return
  local newname; newname=$(prompt "Rename to: ")
  [ -n "$newname" ] && tmux_cmd rename-window -t "$target" "$newname"
}

picker \
  --name      "window" \
  --source    'tmux_cmd list-windows -a -F "#{session_name}:#{window_index} #{window_name}" 2>/dev/null' \
  --on-select handle_select \
  --on-kill   handle_kill \
  --on-rename handle_rename
