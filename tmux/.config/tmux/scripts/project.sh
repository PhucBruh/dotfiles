#!/usr/bin/env bash
# Layout/project picker — load a tmuxifier session layout.
script_dir="$(cd "$(dirname "$0")" && pwd)"
. "$script_dir/lib/picker.sh"

export TMUXIFIER="${TMUXIFIER:-$HOME/.tmux/plugins/tmuxifier}"
export TMUXIFIER_LAYOUT_PATH="$script_dir/../config/layouts"
tmuxifier="$TMUXIFIER/bin/tmuxifier"

[ ! -f "$tmuxifier" ] && echo "tmuxifier not installed. Run prefix+I (TPM install)." && sleep 3 && exit 1

# --- Directory picker (used by layouts with #@needs_dir) ---

pick_directory() {
  local items="$1"
  [ -z "$items" ] && return 1

  local result
  result=$(echo "$items" | fzf --print-query --prompt="Dir: " --height=100% 2>/dev/null) || return 1

  local dir
  dir=$(echo "$result" | tail -1)
  [ -z "$dir" ] && return 1
  dir="${dir/#\~/$HOME}"
  [ "${dir:0:1}" = / ] || dir="$HOME/$dir"
  echo "$dir"
}

resolve_project_dir() {
  local dir=""
  if command -v fd &>/dev/null; then
    local items; items=$(fd --type d --max-depth 3 . "$HOME" 2>/dev/null | sed "s|$HOME/||")
    dir=$(pick_directory "$items") || return 1
  elif command -v find &>/dev/null; then
    local items; items=$(find "$HOME" -maxdepth 3 -type d -not -path '*/\.*' 2>/dev/null | sed "s|$HOME/||")
    dir=$(pick_directory "$items") || return 1
  else
    dir=$(prompt "Dir [$HOME]: ")
    dir="${dir:-$HOME}"
    dir="${dir/#\~/$HOME}"
  fi
  echo "$dir"
}

# --- Main picker ---

handle_select() {
  local selected="$1"
  [ -z "$selected" ] && return

  local layout_file="$TMUXIFIER_LAYOUT_PATH/$selected.session.sh"
  [ ! -f "$layout_file" ] && return

  # If layout needs a project directory, prompt for one
  if grep -q '#@needs_dir' "$layout_file"; then
    local dir
    dir=$(resolve_project_dir) || return
    mkdir -p "$dir" 2>/dev/null
    export PROJECT_DIR="$dir"
    export SESSION_NAME="$(basename "$dir")"
  fi

  "$tmuxifier" load-session "$selected" "${SESSION_NAME:-$selected}"
}

picker \
  --name      "layout" \
  --source    'find "$TMUXIFIER_LAYOUT_PATH" -name "*.session.sh" -printf "%f\n" 2>/dev/null | sed "s/\.session\.sh$//" | sort' \
  --on-select handle_select \
  --one-shot
