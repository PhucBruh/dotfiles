#!/usr/bin/env bash
# Dotfiles picker — select a config entry, then open it in an editor window.
#
# This picker does NOT use the picker() loop because it has a two-phase flow:
#   1. fzf selection (inside the current popup)
#   2. open editor in a NEW window (must happen after the first popup closes)
#
# We use `tmux run-shell -b` to schedule the editor window so it opens cleanly
# after this script (and its popup) exits.
script_dir="$(cd "$(dirname "$0")" && pwd)"
. "$script_dir/lib/picker.sh"

entries_file="$script_dir/../config/entries.sh"
if [ -f "$entries_file" ]; then
  source "$entries_file"
fi
[ ${#entries[@]} -eq 0 ] && exit 0

items=$(printf '%s\n' "${entries[@]}")
selected=$(pick_one "$items" \
  --header 'Enter: open · Esc: exit' \
  --delimiter $'\t' \
  --with-nth 1 \
  --preview 'echo "{2}/{3}"')
[ -z "$selected" ] && exit 0

dir=$(echo "$selected" | awk -F'\t' '{print $2}')
file=$(echo "$selected" | awk -F'\t' '{print $3}')
dir="${dir/#\~/$HOME}"

w=$(tmux_opt @launcher-app-width "90%")
h=$(tmux_opt @launcher-app-height "90%")
editor=$(tmux_opt @launcher-editor "nvim")

if [ -n "$file" ]; then
  path="$dir/$file"
  filedir="$(dirname "$path")"
  editor_cmd="cd '$filedir' && $editor '$path'"
else
  editor_cmd="cd '$dir' && $editor"
fi

# Schedule the editor window to open after this picker popup closes.
tmux run-shell -b "sh ~/.config/tmux/scripts/open-app.sh '$editor' \"$editor_cmd\""
